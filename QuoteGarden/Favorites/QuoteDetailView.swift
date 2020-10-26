//
//  QuoteDetailView.swift
//  QuoteGarden
//
//  Created by Master Family on 07/10/2020.
//

import SwiftUI
import WidgetKit
import CoreData

struct QuoteDetailView: View {

    var genre: String
    var text: String
    var author: String
    var userDefaults = UserDefaults.init(suiteName: "group.com.example.QuoteGarden")
    @State private var displayingOnWidget = false

    var body: some View {

        VStack {
            
            Color.clear.overlay(

            QuoteView(genre: genre, text: text, author: author)
                
                )

            Button(action: { forTheWidget(quoteGenre: genre, quoteText: text, quoteAuthor: author) }) {
                HStack{
                Image(systemName: "arrow.turn.up.forward.iphone")
                Text("Display on widget")
                }

            }.buttonStyle(ColoredButtonStyle())

        }.alert(isPresented: $displayingOnWidget, content: {
            Alert(title: Text("Quote will be displayed in widget"))
        })

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

}
