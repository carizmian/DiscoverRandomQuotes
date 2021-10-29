import Foundation
import UIKit

enum OnboardData {
  // Adding Video:
  // - image: "videoName.mov"
  // - videoInfo: OnboardCard.VideoInfo(originalWidth: ,originalHeight: , newHeight:)
  static func buildSet(width: CGFloat = .infinity, height: CGFloat = .infinity) -> OnboardSet {
    let onboardSet = OnboardSet()
    onboardSet.dimensions(width: width, height: height)
    onboardSet.newCard(
      title: "Welcome",
      image: "Welcome",
      text: NSLocalizedString("onboarding.1", comment: "")
    )
    onboardSet.newCard(
      title: "Reminders",
      image: "Reminder",
      text: NSLocalizedString("onboarding.2", comment: ""),
      buttonInfo: OnboardCard.ButtonInfo(title: "Enable", function: .reminder)
    )
    onboardSet.newCard(
      title: "Widgets",
      image: "Widget",
      text: NSLocalizedString("onboarding.3", comment: "")
    )
    onboardSet.newCard(
      title: "Shake It Up",
      image: "Shake",
      text: NSLocalizedString("onboarding.4", comment: "")
    )
    onboardSet.newCard(
      title: "Premium",
      image: "Shop",
      text: NSLocalizedString("onboarding.5", comment: ""),
      buttonInfo: OnboardCard.ButtonInfo(title: "Store", function: .store)
    )
    return onboardSet
  }
}
