//
//  QuoteDetailView.swift
//  QuoteGarden
//
//  Created by Master Family on 07/10/2020.
//

import SwiftUI

struct QuoteDetailView: View {
    
    var favoriteQuote: QuoteCD
    
    var body: some View {
        
        VStack {
            
            Text("# \(favoriteQuote.wrappedQuoteGenre)")
                .padding()
                .font(Font.system(.subheadline, design: .serif).weight(.light))
            
            
            Text("'\(favoriteQuote.wrappedQuoteText)'")
                .italic()
                .font(Font.system(.title, design: .serif).weight(.ultraLight))
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .layoutPriority(2)
            
            
            Text("~ \(favoriteQuote.wrappedQuoteAuthor)")
                .padding()
                .foregroundColor(.gray)
                .font(Font.system(.callout, design: .serif).weight(.black))
            
        }.padding()

        
    }
}


