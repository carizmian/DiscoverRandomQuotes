import SwiftUI
import Foundation

struct ContentView: View {
  // MARK: - Core Data
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: SavedQuote.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavedQuote.author, ascending: true)]) var savedQuotes: FetchedResults<SavedQuote>
  @State private var showOnboarding = false
  @AppStorage("OnboardBeenViewed") var hasOnboarded = false
  var onboardSet = OnboardData.buildSet(width: .infinity, height: .infinity)
  var body: some View {
    ZStack {
      NavigationView {
        quoteGenerator
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
  var quoteGenerator: some View {
    QuoteGeneratorView(savedQuotes: savedQuotes)
      .accessibilityLabel(Text("Random quotes"))
      .accessibility(hint: Text("Find new quotes here"))
      .navigationBarItems(leading: quoteList, trailing: settings)
  }
  var quoteList: some View {
    NavigationLink(destination: QuoteListView(savedQuotes: savedQuotes)) {
      Image(systemName: "text.quote")
        .font(Font.system(.title2, design: .default).weight(.regular))
        .padding()
    }.accessibilityLabel(Text("Saved quotes"))
    .accessibility(hint: Text("Find your saved quotes here"))
  }
  var settings: some View {
    NavigationLink(destination: SettingsView()) {
      Image(systemName: "gearshape.fill")
        .font(Font.system(.title2, design: .default).weight(.regular))
        .padding()
    }.accessibilityLabel(Text("Settings"))
    .accessibility(hint: Text("Find settings and social links here"))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
