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
    
    func addNotification(title: String, subtitle: String, body: String, timeInterval: TimeInterval) {
        notifications.append(Notification(id: UUID().uuidString, title: title, subtitle: subtitle, body: body, timeInterval: timeInterval))
    }
    
    func addNotifications(reminderFrequency: Double) {
        self.removeAllNotifications()
        
        // every 5 hours
        var timeInterval = reminderFrequency * 3600
        #warning("ali šta nakon šta ovo istekne? kako opet loadat nove citate i scheduelat- i kad?")
        for _ in 1...10 {
            getRandomQuote { quote in
                self.addNotification(title: quote.quoteAuthor, subtitle: quote.quoteGenre, body: quote.quoteText, timeInterval: timeInterval)
                print("Adding notification by: \(quote.quoteAuthor) to notification array!")
                timeInterval += 18000
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
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notification.timeInterval, repeats: false)
                    let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
                    
                    self.center.add(request) { error in
                        guard error == nil else { return }
                        print("""
                            Notification id: \(notification.id),
                            title: \(String(describing: notification.title)),
                            subtitle: \(String(describing: notification.subtitle)),
                            body: \(notification.body)
                            in: \(String(describing: notification.timeInterval / 3600)) hours
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
