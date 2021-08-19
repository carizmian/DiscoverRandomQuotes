import SwiftUI
//import AVKit
import Lottie

struct OnboardingCardView: View {
    @Binding var isShowing: Bool
    let card: OnboardCard
    let width: CGFloat
    let height: CGFloat
    @EnvironmentObject var manager: LocalNotificationManager
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(card.title)
                    .font(.largeTitle)
                Spacer()
                Button(action: {
                    withAnimation {
                        isShowing = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
                
            }
            // Can put VideoInfo instead too!
            if let gifInfo = card.gifInfo {
//                if let url = card.pathToVideo {
//                    VideoPlayer(player: AVPlayer(url: url))
//                        .frame(width: videoInfo.ratio * videoInfo.newHeight, height: videoInfo.newHeight)
//                }
                VStack {
                    LottieView(animationName: gifInfo.name)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .scaleEffect(0.3)
                }.padding()
                
            } else {
                Image(card.image)
                    .resizable()
                    .scaledToFit()
            }
            Text(card.text)
            if let linkInfo = card.linkInfo {
                Button(linkInfo.title) {
                    if let url = URL(string: linkInfo.webLink) {
                        UIApplication.shared.open(url)
                    }
                }.padding()
                .buttonStyle(ColoredButtonStyle())
            }
            Spacer()
        }.padding(.horizontal)
        .padding(.top, 10)
        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(.secondarySystemBackground)))
    }
}
