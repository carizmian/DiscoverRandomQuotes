//
//  QuoteDetailView.swift
//  QuoteGarden
//
//  Created by Master Family on 07/10/2020.
//

import SwiftUI
import WidgetKit


struct QuoteDetailView: View {
    
    var favoriteQuote: QuoteCD
    var userDefaults = UserDefaults.init(suiteName: "group.com.example.QuoteGarden")
    @State private var displayingOnWidget = false
    
    
    var body: some View {
        
        
        VStack {
            
            Text("# \(favoriteQuote.wrappedQuoteGenre)")
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .accessibilityLabel(Text("quote genre is \(favoriteQuote.wrappedQuoteGenre)"))
                
                
            
            
            Text("""
                "\(favoriteQuote.wrappedQuoteText)"
                """)
                .italic()
                .font(Font.system(.title, design: .monospaced).weight(.black))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(favoriteQuote.wrappedQuoteText)"))
            
            
            Text("~ \(favoriteQuote.wrappedQuoteAuthor)")
                .padding(.top)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .accessibilityLabel(Text("quote author is \(favoriteQuote.wrappedQuoteAuthor)"))
            
            
            Button(action: { forTheWidget(quoteGenre: favoriteQuote.wrappedQuoteGenre, quoteText: favoriteQuote.wrappedQuoteText, quoteAuthor: favoriteQuote.wrappedQuoteAuthor) }) {
                Image(systemName: "arrow.turn.up.forward.iphone")
                Text("Display on widget")
                    
            }.font(.title)
            .padding()
            .background(Capsule().fill(Color.purple).shadow(radius: 8, x: 4, y: 4))
            .accentColor(.white)
            .overlay(
                Capsule()
                    .stroke(Color.purple, lineWidth: 4)
                    .scaleEffect(displayingOnWidget ? 2 : 1)
                    .opacity(displayingOnWidget ? 0 : 1))
            .animation(Animation.easeOut(duration: 0.6))
            
        }.padding(.vertical)
        .multilineTextAlignment(.center)
        .alert(isPresented: $displayingOnWidget, content:  {
            Alert(title: Text("Quote will be displayed in widget"))
        })
        
        
        
    }
    
    func forTheWidget(quoteGenre: String, quoteText: String, quoteAuthor: String)  {
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


