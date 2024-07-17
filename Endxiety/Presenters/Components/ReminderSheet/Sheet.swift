//
//  Sheet.swift
//  Endxiety
//
//  Created by robert theo on 16/07/24.
//

import SwiftUI
import UserNotifications


struct Sheet: View {
    @State private var isReminderEnabled = false
    @State private var reminderTime = Date()
    var dateComponents = DateComponents()

    var body: some View {
        NavigationView {
            Form {
                Section(header:
                            Text("Set daily reminders at your preferred time to ensure a consistent writing habit.")
                    .textCase(.none)
                    .font(.system(size: 16))
                    .padding(.bottom)
                ) {
                    Toggle(isOn: $isReminderEnabled) {
                        HStack {
                            Image(systemName: "alarm.fill")
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .background(.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                            Text("Daily Reminder")
                        }.onAppear() {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        
                    }

                    if isReminderEnabled {
                        DatePicker("Reminds Me At", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    }
                }
            }
            .navigationBarTitle("Daily Reminder")
            .navigationBarItems(trailing: Button("Done") {
                print("halo!")

                // Add any actions to perform when done
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.defaultRingtone


                var dateComponents = DateComponents()
                let dateTrigger = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
                dateComponents.hour = dateTrigger.hour
                dateComponents.minute = dateTrigger.minute

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
                print("notification set!")
            
            })
        }
    }
}

#Preview {
    Sheet()
}
