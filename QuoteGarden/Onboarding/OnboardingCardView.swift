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
    #warning(" Mini-savjet: radije izbriši nepotreban kod, nego što ga zakomentiraš, uvijek možeš nešto izbrisano vratiti putem gita natrag.")
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(card.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    withAnimation(.linear(duration: 0.3)) {
                        isShowing = false
                    }
                }) {
                    Image(systemName: "xmark")
                }.buttonStyle(IconButtonStyle())
                
            }.padding(.top, 5.0)
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
                .font(.title3)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            #warning("Refactor me for reusability!")
            if let linkInfo = card.linkInfo {
                Button(linkInfo.title) {
                    if let url = URL(string: linkInfo.webLink) {
                        UIApplication.shared.open(url)
                    }
                }.buttonStyle(TextButtonStyle())
            }
            
            if let buttonInfo = card.buttonInfo {
                Button(buttonInfo.title) {
                    if buttonInfo.function == .store {
                        showBuying.toggle()
                    }
                }.buttonStyle(TextButtonStyle())
            }
            
            Spacer()
            
        }.padding(.horizontal)
        .padding(.top, 10)
        .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.secondarySystemBackground)))
        .sheet(isPresented: $showBuying) {
            BuyStorageSheetView(showBuying: $showBuying)
        }
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    static let onboardSet = OnboardSet.previewSet()
    static var previews: some View {
        Group {
            OnboardingCardView(isShowing: .constant(true), card: onboardSet.cards[4], width: .infinity, height: .infinity)
                .previewLayout(.sizeThatFits)
            OnboardingCardView(isShowing: .constant(true), card: onboardSet.cards[4], width: .infinity, height: .infinity)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
