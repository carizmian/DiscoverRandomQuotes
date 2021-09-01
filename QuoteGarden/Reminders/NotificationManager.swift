import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    let quoteViewModel = QuoteViewModel()
    var notifications = [Notification]()
    var center =  UNUserNotificationCenter.current()
    
    init() {
        print("initialising LocalNotificationManager")
    }
    
    func addNotifications(reminderFrequency: Double) {
        notifications.removeAll()
        var timeInterval = reminderFrequency * 3600
        DispatchQueue.main.async {
            self.quoteViewModel.getRandomQuotes { quotes in
                for quote in quotes {
                    self.addNotification(id: quote.id, title: quote.quoteAuthor, subtitle: quote.quoteGenre, body: quote.quoteText, timeInterval: timeInterval)
                    timeInterval += reminderFrequency * 3600
                    print("Adding notification by: \(quote.quoteAuthor) to notification array!")
                }
            }
            
            // MARK: - Screenshots
//            self.addNotification(id: UUID().uuidString, title: "Henry David Thoreau", subtitle: "motivation", body: "Success usually comes to those who are too busy looking for it", timeInterval: 3.0)
//            self.addNotification(id: UUID().uuidString, title: "John Wooden", subtitle: "success", body: "Success is peace of mind, which is a direct result of self-satisfaction in knowing you made the effort to become the best of which you are capable", timeInterval: 5.0)
        }
    }
    
    func setNotifications() {
        self.center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined, .denied:
                self.requestPermission()
                self.scheduleNotifications()
                print("Not Authorized!")
            case .authorized, .provisional, .ephemeral:
                print("Authorized!")
                self.scheduleNotifications()
            default:
                print("Breaking")
                break
            }
        }
    }
    
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("We have permission!")
            }
        }
    }
    
    private func addNotification(id: String, title: String, subtitle: String, body: String, timeInterval: TimeInterval) {
        notifications.append(Notification(id: id, title: title, subtitle: subtitle, body: body, timeInterval: timeInterval))
    }
    
    private func scheduleNotifications() {
        
        for notification in self.notifications {
            
            // Define the custom actions.
            // let shareAction = UNNotificationAction(identifier: "SHARE_ACTION", title: "Share", options: .foreground)
            // let saveAction = UNNotificationAction(identifier: "SAVE_ACTION", title: "Save", options: .foreground)
            // let playAction = UNNotificationAction(identifier: "PLAY_ACTION", title: "Play Sound", options: .foreground)
            // Define the notification type
            // let quoteActionsCategory = UNNotificationCategory(identifier: "QUOTE_ACTIONS", actions: [shareAction, saveAction, playAction], intentIdentifiers: [], options: .customDismissAction)
            
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.subtitle = notification.subtitle
            content.body = notification.body
            content.sound = UNNotificationSound.default
            // content.categoryIdentifier = "QUOTE_ACTIONS"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notification.timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            // self.center.setNotificationCategories([quoteActionsCategory])
            self.center.add(request) { error in
                guard error == nil else {
                    print(String(describing: error?.localizedDescription))
                    return
                }
                print("""
                    Notification id: \(notification.id),
                    title: \(String(describing: notification.title)),
                    subtitle: \(String(describing: notification.subtitle)),
                    body: \(notification.body)
                    in: \(String(describing: notification.timeInterval / 3600)) hours
                    """)
            }
        }
        notifications.removeAll()
    }
    
}
