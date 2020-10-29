//
//  QuoteGeneratorView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI
import Foundation
import Reachability
import SystemConfiguration

struct QuoteGeneratorView: View {
    
    static let tag: String? = "Home"
    
    @EnvironmentObject var network: NetworkMonitor
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    
    var addToFavorites: (_ id: String, _ text: String, _ author: String, _ genre: String) -> Void
    
    @Binding var changedQuote: Bool
    @Binding var addedToFavorites: Bool
    @State private var addedToClipboard = false
    @State private var showingNetworkAlert = false
    @Binding var showingShareSheetView: Bool
    
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage? = nil
    
    let reachability = try! Reachability()
    
    var body: some View {
        
        VStack {
            
            Color.clear.overlay(
                
                QuoteView(genre: "\(quote.quoteGenre)", text: "\(quote.quoteText)", author: "\(quote.quoteAuthor)")
                    .layoutPriority(2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        changedQuote.toggle()

                        reachability.whenUnreachable = { _ in
                            showingNetworkAlert = true
                            print("Not reachable")
                        }
                        
                        do {
                            try reachability.startNotifier()
                        } catch {
                            print("Unable to start notifier")
                        }
                       
                        QuoteGardenApi().getRandomQuote { quote in
                            
                            self.quote = quote
                            addedToFavorites = false
                            addedToClipboard = false
                        }
                        self.uiimage = self.rect1.uiImage
                    }
                    .animation(.default)
                
            ).getRect($rect1)
            
            
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
                
                Button(action: {
                    self.uiimage = self.rect1.uiImage
                    addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre)
                }) {
                    Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Add quote to your favorites"))
                
                Button(action: {
                    self.uiimage = self.rect1.uiImage
                    copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor)
                }) {
                    Image(systemName: addedToClipboard ? "doc.on.doc.fill" : "doc.on.doc")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Copy quote"))
                
            }
            
        }.animation(.default)
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
    func copyToClipboard(quoteGenre: String, quoteText: String, quoteAuthor: String) {
        
        let quoteString = """
        \(quoteGenre)

        \(quoteText)

        \(quoteAuthor)
        """
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = quoteString
        
        if pasteboard.string != nil {
            print(quoteText)
        }
        
        addedToClipboard = true
    }
    
}

//struct QuoteGeneratorView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteGeneratorView()
//    }
//}
