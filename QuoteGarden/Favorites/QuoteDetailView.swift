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
    var userDefaults = UserDefaults.init(suiteName: "group.com.example.QuoteGarden")
    @State private var displayingOnWidget = false
    @State private var addedToClipboard = false
    @State private var showingShareSheetView = false
    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage? = nil
    
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
                    forTheWidget(quoteGenre: genre, quoteText: text, quoteAuthor: author)
                }) {
                    HStack {
                        Image(systemName: "arrow.turn.up.forward.iphone")
                        Text("Display on widget")
                    }
                    
                }.buttonStyle(ColoredButtonStyle())
                
                Button(action: {
                    copyToClipboard(quoteGenre: genre, quoteText: text, quoteAuthor: author)
                }) {
                    Image(systemName: addedToClipboard ? "doc.on.doc.fill" : "doc.on.doc")
                    
                }.buttonStyle(ColoredButtonStyle())
                .accessibilityLabel(Text("Copy quote"))
                
            }
            
        }.alert(isPresented: $displayingOnWidget, content: {
            Alert(title: Text("Quote will be displayed in widget"))
        })
        .sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
        }
        
    }
    
    func forTheWidget(quoteGenre: String, quoteText: String, quoteAuthor: String) {
        displayingOnWidget = true
        print(displayingOnWidget)
        userDefaults!.set(quoteGenre, forKey: "genre")
        userDefaults!.set(quoteText, forKey: "text")
        userDefaults!.set(quoteAuthor, forKey: "author")
        print(displayingOnWidget)
        
        // requests a reload for all of the widgets
        if userDefaults?.string(forKey: "text") == quoteText {
            
            WidgetCenter.shared.reloadAllTimelines()
            
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
