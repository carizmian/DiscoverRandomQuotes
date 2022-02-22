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
    onboardSet.newCard(
      title: "Welcome",
      image: "Welcome",
      text: "Whether you are going through difficult times or sharing inspirational quotes with your friends, Quotes has you covered."
    )
    onboardSet.newCard(
      title: "Reminders",
      image: "Reminder",
      text: "Reminders are a fun way to learn new stuff. The most important thing is that you are learning every day.",
      buttonInfo: OnboardCard.ButtonInfo(title: "Enable", function: .reminder)
    )
    onboardSet.newCard(
      title: "Widgets",
      image: "Widget",
      text: "Read favorite quotes on your home screen now, featuring widget support."
    )
    onboardSet.newCard(
      title: "Shake It Up",
      image: "Shake",
      text: "Shake to Undo - Accidentally deleted a quote? Shake the device to undo the deletion!  Shake to Generate - Tap on the quote or shake your device to generate a random quote!"
    )
    onboardSet.newCard(
      title: "Premium",
      image: "Shop",
      text: "Premium features made for the best app experience. Choose what you want from the store now!",
      buttonInfo: OnboardCard.ButtonInfo(title: "Store", function: .store)
    )
    return onboardSet
  }
}
