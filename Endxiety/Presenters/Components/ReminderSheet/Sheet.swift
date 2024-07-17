//
//  Sheet.swift
//  Endxiety
//
//  Created by robert theo on 16/07/24.
//

import SwiftUI
import UserNotifications


struct Sheet: View {
    @Binding var showReminderSheet: Bool

    @Binding var isReminderEnabled: Bool
//    @State var isReminderEnabled: Bool = false
    @State private var reminderTime = Date()
    var dateComponents = DateComponents()
    let content = UNMutableNotificationContent()


    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    Toggle(isOn: $isReminderEnabled) {
                        HStack {
                            Image(systemName: "alarm.fill")
                                .foregroundColor(.orange)
                            Text("Daily Reminder")
                        }.onAppear() {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error {
                                    print(error.localizedDescription)
                                }
                            }
                            if content.threadIdentifier.isEmpty {
                                print("ThreadIdentifier is not set")
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
                showReminderSheet = false
                
            })
        }
    }
}

//#Preview {
//    @state var showReminderSheet: Bool = false
//    Sheet(showReminderSheet: $showReminderSheet)
//}
