import UIKit

struct OnboardCard: Identifiable {
    struct VideoInfo {
        let originalWidth: CGFloat
        let originalHeight: CGFloat
        let newHeight: CGFloat
        var ratio: CGFloat {
            originalWidth / originalHeight
        }
    }
        
    struct LinkInfo {
        let title: String
        let webLink: String
    }
    
    enum Function {
        case reminder
        case store
    }
    
    struct ButtonInfo {
        let title: String
        let function: Function
    }
    
    let id = UUID()
    let title: String
    let image: String
    let text: String
    
    // MARK: Optional
    var videoInfo: VideoInfo?
    var pathToVideo: URL? {
        guard let path = Bundle.main.path(forResource: image, ofType: nil) else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
    var linkInfo: LinkInfo?
    var buttonInfo: ButtonInfo?
}
