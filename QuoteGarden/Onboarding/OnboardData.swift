import Foundation
import UIKit

enum OnboardData {
    /*
     Adding Video:
     - image: "videoName.mov"
     - videoInfo: OnboardCard.VideoInfo(originalWidth: ,originalHeight: , newHeight:)
     */
    static func buildSet(width: CGFloat = .infinity, height: CGFloat = .infinity) -> OnboardSet {
        let onboardSet = OnboardSet()
        onboardSet.dimensions(width: width, height: height)
        onboardSet.newCard(title: "Welcome", image: "Welcome", text: "Whether you are going through difficult times, are just bored, or sharing inspirational quotes with your friends, Quotes has you covered.")
        onboardSet.newCard(title: "Reminders", image: "", text: "Unpredictable reminders are a great way to have fun while learning new knowledge", gifInfo: OnboardCard.GifInfo(name: "countdown"), linkInfo: OnboardCard.LinkInfo(title: "Allow Reminders", webLink: ""))
        onboardSet.newCard(title: "Widgets", image: "Widget", text: "Once you saved a quote you can display it on your home screen: From the Home Screen, touch and hold an empty area until the apps jiggle. Then tap the + button in the upper corner to add the widget.")
//        onboardSet.newCard(title: "In-App Purchases", image: "", text: "", gifInfo: OnboardCard.GifInfo(name: "buy"))
//        onboardSet.newCard(title: "Shake to undo", image: "", text: "")
//        onboardSet.newCard(title: "Leave Feedback", image: "Feedback", text: "Thank you for buying my app. Let me know what you think of it. Have any feature requests, suggestions, or bug reports? Please provide feedback by tapping the button below!", linkInfo: OnboardCard.LinkInfo(title: "Leave Feedback", webLink: "https://nikolafranicevic.com/EUVATNumberVIESFreelance/feedback"))
        return onboardSet
    }
}
