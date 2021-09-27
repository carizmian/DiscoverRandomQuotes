import UserNotifications
import SwiftUI

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
  static let shared = NotificationDelegate()
  @Published var quote = Quote(id: "", text: "", author: "", genre: "")
  #warning("Find a way to implement the commented code!")
  #warning("what does override mean?")
  override init() {
    print("initialising LocalNotificationDelegate")
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .badge, .sound])
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // Get the quot e from the original notification.
    quote.id = response.notification.request.identifier
    quote.author = response.notification.request.content.title
    quote.genre = response.notification.request.content.subtitle
    quote.text = response.notification.request.content.body
    // Perform the task associated with the action.
    switch response.actionIdentifier {
    //        case "SHARE_ACTION":
    //
    //            break
    //        case "SAVE_ACTION":
    //
    //            break
    //        case "PLAY_ACTION":
    //
    //            break
    // Handle other actions…
    default:
      print("opening quote")
      //            quoteViewModel.changeQuote(quote)
    }
    // Always call the completion handler when done.
    completionHandler()
  }
}
