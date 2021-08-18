import Foundation
import UIKit

class OnboardSet {
    private(set) var cards: [OnboardCard] = []
    private(set) var width: CGFloat = .infinity
    private(set) var height: CGFloat = .infinity
    
    func dimensions(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    func newCard(title: String, image: String, text: String, videoInfo: OnboardCard.VideoInfo? = nil, gifInfo: OnboardCard.GifInfo? = nil, linkInfo: OnboardCard.LinkInfo? = nil) {
        cards.append(OnboardCard(title: title, image: image, text: text, videoInfo: videoInfo, gifInfo: gifInfo,  linkInfo: linkInfo))
    }
}
