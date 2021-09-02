import SwiftUI
import WidgetKit
import CoreData
import Foundation
import StoreKit
import AVFoundation

struct QuoteDetailView: View {
    
    var favoriteQuote: QuoteCD
    
    @State private var addedToClipboard = false
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?
    let synthesizer: AVSpeechSynthesizer
    
    var body: some View {
        
        VStack {
            
            Color.clear.overlay(
                
                QuoteView(quote: convert(quoteCD: favoriteQuote))
                
            ).getRect($rect1)
            .onChange(of: uiimage) {_ in self.uiimage = self.rect1.uiImage }
            
            HStack {
                
                Button(action: {
                    savePrimary(quoteCD: favoriteQuote)
                }) {
                    Image(systemName: addedToFavorites ? "arrow.turn.up.forward.iphone.fill" : "arrow.turn.up.forward.iphone")
                }.buttonStyle(IconButtonStyle())
                .accessibilityLabel(Text("Display on a widget"))
                .accessibility(hint: Text("Display the quote on a widget"))
                
                Button(action: {
                    self.uiimage = self.rect1.uiImage
                    if self.uiimage != nil {
                        showingShareSheetView = true
                    }
                    
                }) {
                    Image(systemName: "square.and.arrow.up")
                }.buttonStyle(IconButtonStyle())
                .accessibilityLabel(Text("Share quote"))
                .accessibility(hint: Text("opens a share sheet view"))
                
                Button(action: {
                    textToSpeech(quote: favoriteQuote)
                }) {
                    Image(systemName: synthesizer.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                }.buttonStyle(IconButtonStyle())
                .accessibilityLabel(Text("Quote text to speech"))
                .accessibility(hint: Text("Speak the quote text to your ears"))
                .disabled(synthesizer.isSpeaking)
                
            }
            
        }.sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
        
    }
    
    func textToSpeech(quote: QuoteCD) {
        let utterance = AVSpeechUtterance(string: "\(quote.wrappedQuoteAuthor) once said, \(quote.wrappedQuoteText)")
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
    func savePrimary(quoteCD: QuoteCD) {
        
        let quote = Quote(id: quoteCD.id ?? "", quoteText: quoteCD.wrappedQuoteText, quoteAuthor: quoteCD.wrappedQuoteAuthor, quoteGenre: quoteCD.wrappedQuoteGenre)
        
        if #available(iOS 14, *) {
            let newPrimary = PrimaryQuote(primaryQuote: quote)
            newPrimary.storeQuote()
            
        }
        
        addedToFavorites = true
    }
    
    func convert(quoteCD: QuoteCD) -> Quote {
        let quote = Quote(id: quoteCD.id ?? "", quoteText: quoteCD.wrappedQuoteText, quoteAuthor: quoteCD.wrappedQuoteAuthor, quoteGenre: quoteCD.wrappedQuoteGenre)
        return quote
    }
}
