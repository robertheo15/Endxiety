//
//  Sheet.swift
//  Endxiety
//
//  Created by robert theo on 16/07/24.
//

import SwiftUI

struct Sheet: View {
    @State private var isReminderEnabled = false
    @State private var reminderTime = Date()
    var dateComponents = DateComponents()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Daily Reminder")) {
                    Toggle(isOn: $isReminderEnabled) {
                        HStack {
                            Image(systemName: "alarm.fill")
                                .foregroundColor(.orange)
                            Text("Daily Reminder")
                        }
                        
                    }

                    if isReminderEnabled {
                        DatePicker("Reminds Me At", selection: $reminderTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
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
                dateComponents.hour = 22   // 8 AM
                dateComponents.minute = 45 // 0 minutes

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
                print("notification set!")
                let test = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
                print(test.hour)
                print(test.minute)
                
            })
        }
    }
}

#Preview {
    Sheet()
}
