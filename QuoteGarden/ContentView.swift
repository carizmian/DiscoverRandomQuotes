import SwiftUI
import Foundation
import AVFoundation

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var savedToDevice = false
    let synthesizer =  AVSpeechSynthesizer()
    @State private var showOnboarding = false
    @AppStorage("OnboardBeenViewed") var hasOnboarded = false
    var onboardSet = OnboardData.buildSet(width: .infinity, height: .infinity)
    @EnvironmentObject var manager: LocalNotificationManager
    var body: some View {
        ZStack {
            NavigationView {
                QuoteGeneratorView(savedToDevice: $savedToDevice, synthesizer: synthesizer, favoriteQuotes: favoriteQuotes)
                    .tag(QuoteGeneratorView.tag)
                    .accessibilityLabel(Text("Random quotes"))
                    .accessibility(hint: Text("Find new quotes here"))
                    .navigationBarItems(leading:
                                            
                                            NavigationLink(destination: QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes, synthesizer: synthesizer)) {
                                                Image(systemName: "text.quote")
                                                    .font(.largeTitle)
                                            }.accessibilityLabel(Text("Saved quotes"))
                                            .accessibility(hint: Text("Find your saved quotes here")), trailing:
                                                
                                                NavigationLink(destination: SettingsView()) {
                                                    Image(systemName: "gearshape.fill")
                                                        .font(.largeTitle)
                                                }.accessibilityLabel(Text("Settings"))
                                                .accessibility(hint: Text("Find settings and social links here")))
                
            }.navigationViewStyle(StackNavigationViewStyle())
                        .disabled(showOnboarding)
                        .blur(radius: showOnboarding ? 3.0 : 0)
            
                        if showOnboarding {
                            OnboardingScreens(showOnboarding: $showOnboarding, onboardSet: onboardSet)
                        }
            
        }.onAppear {
            moc.undoManager = UndoManager()
            AppReviewRequest.requestReviewIfNeeded()
            // hasOnboarded = false // here for testing
            // When the user dismisses the onboarding view by swiping down, we will also consider onboarding as complete
            if !hasOnboarded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showOnboarding.toggle()
                        hasOnboarded = true
                    }
                }
            }
        }
        
    }
    
    func removeQuote(at offsets: IndexSet) {
        for index in offsets {
            let favoriteQuote = favoriteQuotes[index]
            
            moc.delete(favoriteQuote)
            
        }
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
