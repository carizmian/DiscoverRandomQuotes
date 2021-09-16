import SwiftUI
import Foundation
import AVFoundation

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
  @State private var savedToDevice = false
  let synthesizer = AVSpeechSynthesizer()
  @State private var showOnboarding = false
  @AppStorage("OnboardBeenViewed") var hasOnboarded = false
  var onboardSet = OnboardData.buildSet(width: .infinity, height: .infinity)
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
                                    .font(Font.system(.title3, design: .default).weight(.regular))
                                    .padding()
                                }.accessibilityLabel(Text("Saved quotes"))
                                .accessibility(hint: Text("Find your saved quotes here")), trailing:
                                  NavigationLink(destination: SettingsView()) {
                                    Image(systemName: "gearshape.fill")
                                      .font(Font.system(.title3, design: .default).weight(.regular))
                                      .padding()
                                  }.accessibilityLabel(Text("Settings"))
                                  .accessibility(hint: Text("Find settings and social links here")))
      }.navigationViewStyle(StackNavigationViewStyle())
      .disabled(showOnboarding)
      .blur(radius: showOnboarding ? 3.0 : 0)
      if showOnboarding {
        OnboardingScreenView(showOnboarding: $showOnboarding, onboardSet: onboardSet)
      }
    }.onAppear {
      moc.undoManager = UndoManager()
      AppReviewRequest.requestReviewIfNeeded()
      #warning("ONBOARDING")
      //hasOnboarded = false // here for testing
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
