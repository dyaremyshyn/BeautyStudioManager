//
//  NotificationService.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 04/04/2025.
//

import UserNotifications
import Foundation

struct NotificationService {
    
    static func scheduleDailyNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = tr.notificationDailyReminder
                content.body = tr.notificationDailyReminderBody
                content.sound = UNNotificationSound.default
                
                var dateComponents = DateComponents()
                dateComponents.hour = 21
                dateComponents.minute = 00
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
                
                center.add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Permission not granted or an error occurred: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
