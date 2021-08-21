import UserNotifications
import SwiftUI

class LocalNotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
    #warning("bolji način")
//    var quoteViewModel = QuoteViewModel()
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Get the quote from the original notification.
        quote.quoteAuthor = response.notification.request.content.title
        quote.quoteGenre = response.notification.request.content.subtitle
        quote.quoteText = response.notification.request.content.body
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
            break
        }
        // Always call the completion handler when done.
        completionHandler()
    }
}
