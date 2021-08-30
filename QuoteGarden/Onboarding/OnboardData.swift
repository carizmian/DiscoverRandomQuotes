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
        onboardSet.newCard(title: "Welcome",
                           image: "Welcome",
                           text: "Whether you are going through difficult times, are just bored, or sharing inspirational quotes with your friends, Quotes has you covered.")
        onboardSet.newCard(title: "Reminders",
                           image: "Reminder",
                           text: "Surprising reminders are a great way to have fun while learning new knowledge. The most important thing is that you are learning every day.")
        onboardSet.newCard(title: "Widgets",
                           image: "Widget",
                           text: "Once you saved a quote you can display it on your home screen: from the Home Screen, touch and hold an empty area until the apps jiggle. Then tap the + button in the upper corner to add the widget.")
        onboardSet.newCard(title: "Shake to Undo",
                           image: "Shake", text: "Shake to Undo - Accidentally deleted a quote? Shake the device to undo the deletion!")
        onboardSet.newCard(title: "Premium",
                           image: "Shop",
                           text: "Premium features made for the best app experience. Choose what you want from the store now!",
                           buttonInfo: OnboardCard.ButtonInfo(title: "Store", function: .store))
        return onboardSet
    }
}
