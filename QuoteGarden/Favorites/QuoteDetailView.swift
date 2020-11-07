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

struct QuoteDetailView: View {
    
    var genre: String
    var text: String
    var author: String
    @State private var addedToClipboard = false
    @State private var showingShareSheetView = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?
    
    var body: some View {
        
        VStack {
            
            Color.clear.overlay(
                
                QuoteView(genre: genre, text: text, author: author)

            ).getRect($rect1)
            .onChange(of: uiimage) {_ in self.uiimage = self.rect1.uiImage }
            
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
                    copyToClipboard(quoteGenre: genre, quoteText: text, quoteAuthor: author)
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
