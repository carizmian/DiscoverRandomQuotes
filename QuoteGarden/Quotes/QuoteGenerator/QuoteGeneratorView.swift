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
  // MARK: - Environment
  static let tag: String? = "Home"
  @Environment(\.managedObjectContext) var moc
  @EnvironmentObject var quoteViewModel: QuoteViewModel
  @EnvironmentObject var storage: Storage
  @Binding var savedToDevice: Bool
  @State private var addedToClipboard = false
  @State private var rect1: CGRect = .zero
  @State private var uiImage: UIImage?
  @State private var viewState = CGSize.zero
  let synthesizer: AVSpeechSynthesizer
  var favoriteQuotes: FetchedResults<QuoteCD>
  @State private var activeSheet: ActiveSheet?
  @ObservedObject var delegate = NotificationDelegate.shared
  @State private var showBuying = false
  @State var attempts: Int = 0
  var body: some View {
    ZStack {
      ShakableViewRepresentable()
        .allowsHitTesting(false)
      VStack {
        Color.clear.overlay(
          QuoteView(quote: quoteViewModel.quote)
            .animation(.spring())
            .onTapGesture {
              quoteViewModel.changeQuote(quoteViewModel.quote)
              quoteViewModel.quote = Quote(id: "", text: "", author: "", genre: "")
              quoteViewModel.getRandomQuote()
              savedToDevice = false
              addedToClipboard = false
            }
            .onReceive(NotificationCenter.default.publisher(
              for: UIApplication.didBecomeActiveNotification
            )) { _ in
              // The app became active
              #warning("Maybe there is a better way!")
              if !delegate.quote.text.isEmpty {
                // use the notification delegate quote
                savedToDevice = false
                quoteViewModel.changeQuote(delegate.quote)
                delegate.quote.text = ""
              }
            }
        ).getRect($rect1)
        .onChange(of: uiImage) { _ in self.uiImage = self.rect1.uiImage }
        .accessibility(addTraits: .isButton)
        .accessibility(label: Text("Change quote"))
        .accessibility(hint: Text("Changes quote when tapped, and display them"))
        HStack {
          Button {
            self.uiImage = self.rect1.uiImage
            if self.uiImage != nil {
              activeSheet = .shareSheetView
            }
          } label: {
            Image(systemName: "square.and.arrow.up")
          }.buttonStyle(IconButtonStyle())
          .accessibilityLabel(Text("Share quote"))
          .accessibility(hint: Text("opens a share sheet view"))
          if favoriteQuotes.count < storage.amount { Button {
            saveToDevice(quote: quoteViewModel.quote)
          } label: {
            Image(systemName: savedToDevice ? "bookmark.fill" : "bookmark")
          }.buttonStyle(IconButtonStyle())
          .accessibilityLabel(Text("Save quote"))
          .accessibility(hint: Text("Save the quote to your device, so you can access it later"))
          } else if  favoriteQuotes.count >= storage.amount {
            Button {
              activeSheet = .buyStorageSheetView
            } label: {
              Image(systemName: savedToDevice ? "bookmark.fill" : "bookmark")
            }.buttonStyle(IconButtonStyle())
            .accessibilityLabel(Text("Save quote"))
            .accessibility(hint: Text("Save the quote to your device, so you can access it later"))
          }
          Button {
            textToSpeech(quote: quoteViewModel.quote)
          } label: {
            Image(systemName: synthesizer.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
          }.buttonStyle(IconButtonStyle())
          .accessibilityLabel(Text("Quote text to speech"))
          .accessibility(hint: Text("Speak the quote text to your ears"))
          .disabled(synthesizer.isSpeaking)
        }.disabled(quoteViewModel.quote.text.isEmpty)
      }
    }.onReceive(messagePublisher) { _ in
      quoteViewModel.changeQuote(quoteViewModel.quote)
      quoteViewModel.quote = Quote(id: "", text: "", author: "", genre: "")
      quoteViewModel.getRandomQuote()
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
  func textToSpeech(quote: Quote) {
    let utterance = AVSpeechUtterance(string: "\(quote.author) once said, \(quote.text)")
    let voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.voice = voice
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: .duckOthers)
      try AVAudioSession.sharedInstance().setActive(true)
      if synthesizer.isSpeaking == false {
        synthesizer.speak(utterance)
      }
    } catch {
      print(error)
    }
  }
  func saveToDevice(quote: Quote) {
    savedToDevice.toggle()
    if savedToDevice == true {
      let favoriteQuote = QuoteCD(context: self.moc)
      favoriteQuote.id = quote.id
      favoriteQuote.quoteText = quote.text
      favoriteQuote.quoteAuthor = quote.author
      favoriteQuote.quoteGenre = quote.genre
      try? self.moc.save()
    } else {
      moc.undo()
    }
  }
}
