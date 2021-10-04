import SwiftUI
import Foundation
import SystemConfiguration
import AVFoundation

enum ActiveSheet: Identifiable {
  case shareSheetView, buyStorageSheetView
  var id: Int {
    hashValue
  }
}

struct QuoteGeneratorView: View {
  // MARK: - Core Data
  @Environment(\.managedObjectContext) var moc
  var savedQuotes: FetchedResults<SavedQuote>
  @EnvironmentObject var quoteViewModel: QuoteViewModel
  @EnvironmentObject var storage: Storage
  @StateObject var notificationDelegate = NotificationDelegate.shared
  // MARK: - View
  @State private var activeSheet: ActiveSheet?
  @State private var savedToDevice = false
  @State private var addedToClipboard = false
  @State private var rect1: CGRect = .zero
  @State private var uiImage: UIImage?
  @State private var viewState = CGSize.zero
  @State private var showBuying = false
  @State private var attempts: Int = 0
  // MARK: - AVFoundation
  @StateObject var speechManager = SpeechManager.shared
  @StateObject var speechDelegate = SpeechDelegate.shared
  var body: some View {
    ZStack {
      ShakableViewRepresentable()
        .allowsHitTesting(false)
      VStack {
        Color.clear.overlay(
          QuoteView(quote: quoteViewModel.quote)
            .animation(.spring())
            .onTapGesture {
              quoteViewModel.fetchQuote()
              savedToDevice = false
              addedToClipboard = false
            }
            .onReceive(NotificationCenter.default.publisher(
              for: UIApplication.didBecomeActiveNotification
            )) { _ in
              // The app became active
              #warning("Maybe there is a better way!")
              if !notificationDelegate.quote.text.isEmpty {
                // use the notification delegate quote
                savedToDevice = false
                quoteViewModel.updateQuote(with: notificationDelegate.quote)
                notificationDelegate.quote.text = ""
              }
            }
        ).getRect($rect1)
        .onChange(of: uiImage) { _ in self.uiImage = self.rect1.uiImage }
        .accessibility(addTraits: .isButton)
        .accessibility(label: Text("Change quote"))
        .accessibility(hint: Text("Changes quote when tapped, and display them"))
        HStack {
          shareButton
          if savedQuotes.count < storage.amount {
            saveButton
          } else if  savedQuotes.count >= storage.amount {
            buyMoreStorageButton
          }
          #warning("isSpeaking = false after quote is read")
          speakButton
        }.disabled(quoteViewModel.quote.text.isEmpty)
      }
    }.onReceive(messagePublisher) { _ in
      quoteViewModel.fetchQuote()
      savedToDevice = false
      addedToClipboard = false
      print("Shaking")
    }
    .sheet(item: $activeSheet) { item in
      switch item {
      case .shareSheetView:
        if let uiImage = uiImage {
          ShareSheetView(activityItems: [
            uiImage
          ])
        }
      case .buyStorageSheetView:
        BuyStorageView()
      }
    }
  }
  func saveToDevice(quote: Quote) {
    savedToDevice.toggle()
    if savedToDevice == true {
      let favoriteQuote = SavedQuote(context: self.moc)
      favoriteQuote.id = quote.id
      favoriteQuote.text = quote.text
      favoriteQuote.author = quote.author
      favoriteQuote.genre = quote.genre
      try? self.moc.save()
    } else {
      moc.undo()
    }
  }
  // MARK: - Share
  var shareButton: some View {
    Button {
      self.uiImage = self.rect1.uiImage
      if self.uiImage != nil {
        activeSheet = .shareSheetView
      }
    } label: {
      Image(systemName: activeSheet == ActiveSheet.shareSheetView ? "square.and.arrow.up.fill" : "square.and.arrow.up")
    }.buttonStyle(IconButtonStyle())
    .accessibilityLabel(Text("Share quote"))
    .accessibility(hint: Text("opens a share sheet view"))
  }
  // MARK: - Save
  var saveButton: some View {
    Button {
      saveToDevice(quote: quoteViewModel.quote)
    } label: {
      Image(systemName: savedToDevice ? "bookmark.fill" : "bookmark")
    }.buttonStyle(IconButtonStyle())
    .accessibilityLabel(Text("Save quote"))
    .accessibility(hint: Text("Save the quote to your device, so you can access it later"))
  }
  var buyMoreStorageButton: some View {
    Button {
      activeSheet = .buyStorageSheetView
    } label: {
      Image(systemName: savedToDevice ? "bookmark.fill" : "bookmark")
    }.buttonStyle(IconButtonStyle())
    .accessibilityLabel(Text("Save quote"))
    .accessibility(hint: Text("Save the quote to your device, so you can access it later"))
  }
  // MARK: - Speak
  var speakButton: some View {
    Button {
      speechManager.textToSpeech(quote: quoteViewModel.quote)
    } label: {
      Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
    }.buttonStyle(IconButtonStyle())
    .accessibilityLabel(Text("Quote text to speech"))
    .accessibility(hint: Text("Speak the quote text to your ears"))
  }
}
