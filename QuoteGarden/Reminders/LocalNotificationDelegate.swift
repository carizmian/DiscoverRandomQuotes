import UserNotifications
import SwiftUI

class LocalNotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
    #warning("Find a way to implement the commented code!")
    
    #warning("ovo override nez sta radi")
    override init() {
        print("initialising LocalNotificationDelegate")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Get the quote from the original notification.
        quote.id = response.notification.request.identifier
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
