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
        onboardSet.newCard(title: "Reminders", image: "Reminder", text: "Surprising reminders are a great way to have fun while learning new knowledge. The most important thing is that you are learning every day.")
        onboardSet.newCard(title: "Widgets", image: "Widget", text: "Once you saved a quote you can display it on your home screen: from the Home Screen, touch and hold an empty area until the apps jiggle. Then tap the + button in the upper corner to add the widget.")
        onboardSet.newCard(title: "Shake to Undo", image: "Shake", text: "Shake to Undo - Accidentally deleted a quote? Shake the device to undo the deletion!")
        onboardSet.newCard(title: "In-App Purchases", image: "Shop", text: "Premium features made for the best app experience. Choose what you want from the store now!", linkInfo: OnboardCard.LinkInfo(title: "Store", webLink: ""))

//        onboardSet.newCard(title: "Leave Feedback", image: "Feedback", text: "Thank you for buying my app. Let me know what you think of it. Have any feature requests, suggestions, or bug reports? Please provide feedback by tapping the button below!", linkInfo: OnboardCard.LinkInfo(title: "Leave Feedback", webLink: "https://nikolafranicevic.com/EUVATNumberVIESFreelance/feedback"))
        return onboardSet
    }
}
