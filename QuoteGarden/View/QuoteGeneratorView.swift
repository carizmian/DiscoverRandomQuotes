//
//  QuoteGeneratorView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI
import Foundation
import SystemConfiguration
import AVFoundation

struct QuoteGeneratorView: View {
    
    static let tag: String? = "Home"
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
    
    @Binding var savedToDevice: Bool
    @Binding var showingShareSheetView: Bool
    
    @State private var addedToClipboard = false
    @State private var showingNetworkAlert = false
    
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?
    
    @State var viewState = CGSize.zero
    
    let synthesizer: AVSpeechSynthesizer
    
    var body: some View {
        
        VStack {
            
            Color.clear.overlay(
                
                QuoteView(quote: quote)
                    .gesture(
                        LongPressGesture().onChanged { _ in
                            quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
                            
                            getRandomQuote { quote in
                                
                                self.quote = quote
                                savedToDevice = false
                                addedToClipboard = false
                            }
                        }
                    )
                    .animation(.spring())
                
            ).getRect($rect1)
            .onChange(of: uiimage) {_ in self.uiimage = self.rect1.uiImage }
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text("Change quote"))
            .accessibility(hint: Text("Changes quote when tapped, and display them"))
            
            HStack {
                
                Button(action: {
                    self.uiimage = self.rect1.uiImage
                    if self.uiimage != nil {
                        showingShareSheetView = true
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Share quote"))
                .accessibility(hint: Text("opens a share sheet view"))
                
                Button(action: {
                    saveToDevice(quote: quote)
                }) {
                    Image(systemName: savedToDevice ? "bookmark.fill" : "bookmark")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Save quote"))
                .accessibility(hint: Text("Save the quote to your device, so you can access it later"))
                
                Button(action: {
                    textToSpeech(quote: quote)
                }) {
                    Image(systemName: synthesizer.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Quote text to speech"))
                .accessibility(hint: Text("Speak the quote text to your ears"))
                .disabled(synthesizer.isSpeaking)
                
            }.disabled(quote.quoteText == "")
            
        }
        .sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
        .alert(isPresented: $showingNetworkAlert) {
            Alert(title: Text("No internet connection"), message: Text("Please connect to the internet!"))
        }
        
    }
    
    func textToSpeech(quote: Quote) {
        let utterance = AVSpeechUtterance(string: "\(quote.quoteAuthor) once said, \(quote.quoteText)")
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
            favoriteQuote.quoteText = quote.quoteText
            favoriteQuote.quoteAuthor = quote.quoteAuthor
            favoriteQuote.quoteGenre = quote.quoteGenre
            try? self.moc.save()
        } else {
            moc.undo()
        }
        
    }
    
//    func getRandomQuote(completion: @escaping (Quote) -> Void) {
//        
//        let randomPage = Int.random(in: 1..<2)
//        let randomQuote = Int.random(in: 0..<36335)
//        
//        let url = Bundle.main.url(forResource: "quotes\(randomPage).json", withExtension: nil)
//        
//        URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard let data = data else {
//                print(String(describing: error))
//                return
//            }
//            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
//                print(String(describing: error))
//                return
//            }
//            DispatchQueue.main.async {
//                completion(response.data[randomQuote])
//            }
//            //print(String(data: data, encoding: .utf8)!)
//        }.resume()
//        
//    }
    
}
