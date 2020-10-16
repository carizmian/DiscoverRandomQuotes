//
//  LocalNotificationManager.swift
//  QuoteGarden
//
//  Created by Master Family on 15/10/2020.
//

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
}

class LocalNotificationManager {
    
    var notifications = [Notification]()
    
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil {
                    self.scheduleNotifications(date: DateComponents())
                }
            }
        
    }
    
    func addNotification(title: String) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title))
    }
    
    
    func scheduleNotifications(date: DateComponents) -> Void {
        for notification in notifications {
            
            let content = UNMutableNotificationContent()
            content.title = notification.title

            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id), title: \(notification.title)")
            }
        }
    }
    
    func schedule(components: DateComponents) -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
                
            case .authorized, .provisional:
                self.scheduleNotifications(date: components)
                
            default:
                break
            }
            
        }
    }
}
