import SwiftUI

struct OnboardingScreens: View {
    @Binding var showOnboarding: Bool
    var onboardSet: OnboardSet
    @ObservedObject var manager = NotificationManager.shared
    var body: some View {
        VStack {
            TabView {
                ForEach(onboardSet.cards) { card in
                    OnboardingCardView(isShowing: $showOnboarding, card: card, width: onboardSet.width, height: onboardSet.height)
                    
                }
            }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Spacer()
            
        }.edgesIgnoringSafeArea(.all)
        .padding()
        .padding(.bottom)
        .onAppear {
            // 3 Hours is default
            manager.addNotifications(reminderFrequency: 3.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                manager.requestPermission()
            }
        }.onDisappear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                manager.setNotifications()
            }
        }
    }
}
