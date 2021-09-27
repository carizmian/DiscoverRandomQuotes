import UserNotifications

class NotificationManager: ObservableObject {
  static let shared = NotificationManager()
  let quoteViewModel = QuoteViewModel()
  var notifications: [Notification] = Array()
  var center = UNUserNotificationCenter.current()
  @Published var sendReminders: Bool = UserDefaults.standard.optionalBool(forKey: "sendReminders") ?? false {
    didSet {
      UserDefaults.standard.set(sendReminders, forKey: "sendReminders")
      print("setting sendReminders - \(sendReminders) - UserDefaults")
    }
  }
  @Published var reminderFrequency: Double = UserDefaults.standard.optionalDouble(forKey: "reminderFrequency") ?? 3.0 {
    didSet {
      UserDefaults.standard.set(reminderFrequency, forKey: "reminderFrequency")
      print("setting reminderFrequency - \(reminderFrequency) - UserDefaults")
    }
  }
  init() {
    print("initialising LocalNotificationManager")
  }
  func addNotifications() {
    notifications.removeAll()
    var timeInterval = self.reminderFrequency * 3600
    DispatchQueue.main.async {
      self.quoteViewModel.fetchQuotes { quotes in
        for quote in quotes {
          self.addNotification(id: quote.id, title: quote.author, subtitle: quote.genre, body: quote.text, timeInterval: timeInterval)
          timeInterval += self.reminderFrequency * 3600
          print("\(quote.author) -> array")
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
      }
    }
  }
  func requestPermission() {
    center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if granted == true && error == nil {
        DispatchQueue.main.async {
          self.sendReminders = true
        }
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
        print(
          """
          scheduling ⚙️
          id: \(notification.id),
          author: \(String(describing: notification.title)),
          time: \(String(describing: notification.timeInterval / 3600)) hours
          """
        )
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      print("emptied notification array")
      self.notifications.removeAll()
    }
  }
}
