import UserNotifications

class LocalNotificationManager: ObservableObject {
    var notifications = [Notification]()
    let center =  UNUserNotificationCenter.current()
    
    #warning("Is it okay to create a instance here?")
    let quoteViewModel = QuoteViewModel()
    
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
    
    func addNotification(id: String, title: String, subtitle: String, body: String, timeInterval: TimeInterval) {
        notifications.append(Notification(id: id, title: title, subtitle: subtitle, body: body, timeInterval: timeInterval))
    }
    
    func addNotifications(reminderFrequency: Double) {
        self.removeAllNotifications()
        
        var timeInterval = reminderFrequency * 3600
        DispatchQueue.main.async {
            self.quoteViewModel.getRandomQuotes { quotes in
                for quote in quotes {
                    self.addNotification(id: quote.id, title: quote.quoteAuthor, subtitle: quote.quoteGenre, body: quote.quoteText, timeInterval: timeInterval)
                    print("Adding notification by: \(quote.quoteAuthor) to notification array!")
                    timeInterval += 18000
                }
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
                
                // Define the custom actions.
                //                let shareAction = UNNotificationAction(identifier: "SHARE_ACTION", title: "Share", options: .foreground)
                //                let saveAction = UNNotificationAction(identifier: "SAVE_ACTION", title: "Save", options: .foreground)
                //                let playAction = UNNotificationAction(identifier: "PLAY_ACTION", title: "Play Sound", options: .foreground)
                // Define the notification type
                //                let quoteActionsCategory = UNNotificationCategory(identifier: "QUOTE_ACTIONS", actions: [shareAction, saveAction, playAction], intentIdentifiers: [], options: .customDismissAction)
                
                for notification in self.notifications {
                    
                    let content = UNMutableNotificationContent()
                    content.title = notification.title
                    content.subtitle = notification.subtitle
                    content.body = notification.body
                    content.sound = UNNotificationSound.default
                    //                    content.categoryIdentifier = "QUOTE_ACTIONS"
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notification.timeInterval, repeats: false)
                    let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
                    
                    //                    self.center.setNotificationCategories([quoteActionsCategory])
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
