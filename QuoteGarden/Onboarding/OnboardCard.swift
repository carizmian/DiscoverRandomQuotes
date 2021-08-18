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
    
    struct GifInfo {
        let name: String
    }
    
    struct LinkInfo {
        let title: String
        let webLink: String
    }
    
    let id = UUID()
    let title: String
    let image: String
    let text: String
    
    // MARK: Optional
    var videoInfo: VideoInfo? = nil
    var pathToVideo: URL? {
        guard let path = Bundle.main.path(forResource: image, ofType: nil) else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
    var gifInfo: GifInfo? = nil
    var linkInfo: LinkInfo? = nil
}
