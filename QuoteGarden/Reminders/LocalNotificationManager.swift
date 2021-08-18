import UserNotifications

class LocalNotificationManager: ObservableObject {
    var notifications = [Notification]()
    let center =  UNUserNotificationCenter.current()
    
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                self.scheduleNotifications()
                // We have permission!
            }
        }
    }
    
    func removeAllNotifications() {
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        print("Removed all notifications!")
    }
    
    func addNotification(title: String, subtitle: String, body: String, dateComponents: DateComponents) {
        notifications.append(Notification(id: UUID().uuidString, title: title, subtitle: subtitle, body: body, dateComponents: dateComponents))
    }
    
    func addNotifications() {
        self.removeAllNotifications()
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 8
        dateComponents.minute = Int.random(in: 0...59)
        
        for hour in 9...19 {
            getRandomQuote { quote in
                self.addNotification(title: quote.quoteAuthor, subtitle: quote.quoteGenre, body: quote.quoteText, dateComponents: dateComponents)
                print("Adding notification by: \(quote.quoteAuthor) to notification array!")
                
                dateComponents.hour = hour
                dateComponents.minute = Int.random(in: 0...59)
                
            }
        }

    }
    
    func scheduleNotifications() {
        self.center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined, .denied:
                print("Not Authorized!")
                self.requestPermission()
            case .authorized, .provisional, .ephemeral:
                print("Authorized!")
                for notification in self.notifications {
                    let content = UNMutableNotificationContent()
                    content.title = "~ \(notification.title)"
                    content.subtitle = "# \(notification.subtitle)"
                    content.body = notification.body
                    content.sound = UNNotificationSound.default
                    #warning("ovo ce slat iste citate nakon 1 dana!")
                    let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dateComponents, repeats: false)
                    let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
                    
                    self.center.add(request) { error in
                        guard error == nil else { return }
                        print("""
                            Notification id: \(notification.id),
                            title: \(String(describing: notification.title)),
                            subtitle: \(String(describing: notification.subtitle)),
                            body: \(notification.body)
                            hour: \(String(describing: notification.dateComponents.hour)) minute: \(String(describing: notification.dateComponents.minute))
                            """)
                    }
                }
            default:
                print("Breaking")
                break
            }
        }
    }
    
}
