//
//  ContentView.swift
//  QuoteGarden-AppClip
//
//  Created by Master Family on 06/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
    @Binding var showingShareSheetView: Bool
    @State private var addedToClipboard = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?
    @State var viewState = CGSize.zero
    
    var body: some View {
        VStack {
            
            Color.clear.overlay(
                
                QuoteView(quote: quote)
                    .gesture(
                        LongPressGesture().onChanged { _ in
                            quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
                            
                            QuoteGardenApi().getRandomQuote { quote in
                                
                                self.quote = quote
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
                    copyToClipboard(quote: quote)
                }) {
                    Image(systemName: addedToClipboard ? "doc.on.doc.fill" : "doc.on.doc")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Copy quote"))
                .accessibility(hint: Text("Copy the quote text to your clipboard"))
                
            }.disabled(quote.quoteText == "")
            
        }
        .sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
    }
    func copyToClipboard(quote: Quote) {
        let quoteString = """
        # \(quote.quoteGenre)
        \(quote.quoteText)
        ~ \(quote.quoteAuthor)

        From the Spontaneous app: https://apps.apple.com/us/app/spontaneous-random-quotes/id1538265374
        """
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = quoteString
        
        if pasteboard.string != nil {
            print(quoteString)
        }
        
        addedToClipboard = true
    }
}
