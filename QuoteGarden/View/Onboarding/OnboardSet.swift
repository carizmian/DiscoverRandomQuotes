import Foundation
import UIKit

class OnboardSet {
    private(set) var cards: [OnboardCard] = []
    private(set) var width: CGFloat = .infinity
    private(set) var height: CGFloat = .infinity
    
    init() {
        print("initialising OnboardSet")
    }
    
    func dimensions(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    func newCard(title: String, image: String, text: String, videoInfo: OnboardCard.VideoInfo? = nil, linkInfo: OnboardCard.LinkInfo? = nil, buttonInfo: OnboardCard.ButtonInfo? = nil) {
        cards.append(OnboardCard(title: title, image: image, text: text, videoInfo: videoInfo, linkInfo: linkInfo, buttonInfo: buttonInfo))
    }
}

extension OnboardSet {
    static func previewSet() -> OnboardSet {
        let onboardSet = OnboardSet()
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
