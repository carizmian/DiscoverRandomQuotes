import SwiftUI
import AVKit

struct OnboardingCardView: View {
    @Binding var isShowing: Bool
    let card: OnboardCard
    let width: CGFloat
    let height: CGFloat
    @EnvironmentObject var store: Store
    @EnvironmentObject var storage: Storage
    @State var showBuying = false
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
            if let videoInfo = card.videoInfo {
                if let url = card.pathToVideo {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(width: videoInfo.ratio * videoInfo.newHeight, height: videoInfo.newHeight)
                }
                
            } else {
                Image(card.image)
                    .resizable()
                    .scaledToFit()
            }
            Text(card.text)
            #warning("Refactor me for reusability!")
            if let linkInfo = card.linkInfo {
                Button(action: {showBuying.toggle()}) {
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("Storage")
                    }
                }.padding()
                .buttonStyle(ColoredButtonStyle())
                
                //                Button(linkInfo.title) {
                //                    if let url = URL(string: linkInfo.webLink) {
                //                       UIApplication.shared.open(url)
                //
                //                    }
                //                }.padding()
                //                .buttonStyle(ColoredButtonStyle())
            }
            Spacer()
        }.padding(.horizontal)
        .padding(.top, 10)
        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(.secondarySystemBackground)))
        .sheet(isPresented: $showBuying) {
            BuyStorageSheetView(showBuying: $showBuying)
        }
    }
}
