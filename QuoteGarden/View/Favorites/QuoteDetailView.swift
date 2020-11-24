//
//  QuoteDetailView.swift
//  QuoteGarden
//
//  Created by Master Family on 07/10/2020.
//

import SwiftUI
import WidgetKit
import CoreData
import Foundation
import StoreKit

struct QuoteDetailView: View {
    
    var favoriteQuote: QuoteCD
    
    @State private var addedToClipboard = false
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?
    
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
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Display on widget"))
                
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
                    copyToClipboard(quoteGenre: favoriteQuote.wrappedQuoteGenre, quoteText: favoriteQuote.wrappedQuoteText, quoteAuthor: favoriteQuote.wrappedQuoteAuthor)
                }) {
                    Image(systemName: addedToClipboard ? "doc.on.doc.fill" : "doc.on.doc")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Copy quote"))
                
            }
            
        }.sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
        .onAppear {
            AppReviewRequest.requestReviewIfNeeded()
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
