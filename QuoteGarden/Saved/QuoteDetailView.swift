import SwiftUI
import WidgetKit
import CoreData
import Foundation
import StoreKit
import AVFoundation

struct QuoteDetailView: View {
  var savedQuote: SavedQuote
  @State private var isCopied = false
  @State private var isSaved = false
  @State private var isSharing = false
  @State private var rect1: CGRect = .zero
  @State private var uiImage: UIImage?
  let synthesizer = SpeechSynthesizer.shared
  var body: some View {
    VStack {
      Color.clear.overlay(
        QuoteView(quote: convert(quote: savedQuote))
      ).getRect($rect1)
      .onChange(of: uiImage) { _ in self.uiImage = self.rect1.uiImage }
      HStack {
        Button {
          save(quote: savedQuote)
        } label: {
          Image(systemName: isSaved ? "arrow.turn.up.forward.iphone.fill" : "arrow.turn.up.forward.iphone")
        }.buttonStyle(IconButtonStyle())
        .accessibilityLabel(Text("Display on a widget"))
        .accessibility(hint: Text("Display the quote on a widget"))
        Button {
          self.uiImage = self.rect1.uiImage
          if self.uiImage != nil {
            isSharing = true
          }
        } label: {
          Image(systemName: "square.and.arrow.up")
        }.buttonStyle(IconButtonStyle())
        .accessibilityLabel(Text("Share quote"))
        .accessibility(hint: Text("opens a share sheet view"))
        Button {
          synthesizer.textToSpeech(quote: convert(quote: savedQuote))
        } label: {
          Image(systemName: synthesizer.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
        }.buttonStyle(IconButtonStyle())
        .accessibilityLabel(Text("Quote text to speech"))
        .accessibility(hint: Text("Speak the quote text to your ears"))
        .disabled(synthesizer.isSpeaking)
      }
    }.sheet(isPresented: $isSharing) {
      if let uiimage = uiImage {
        ShareSheetView(activityItems: [
          uiimage
        ])
      }
    }
  }
  func save(quote: SavedQuote) {
    let quote = Quote(id: quote.id ?? "", text: quote.wrappedText, author: quote.wrappedAuthor, genre: quote.wrappedGenre)
    if #available(iOS 14, *) {
      let newPrimary = PrimaryQuote(primaryQuote: quote)
      newPrimary.storeQuote()
    }
    isSaved = true
  }
  func convert(quote: SavedQuote) -> Quote {
    let quote = Quote(id: quote.id ?? "", text: quote.wrappedText, author: quote.wrappedAuthor, genre: quote.wrappedGenre)
    return quote
  }
}
