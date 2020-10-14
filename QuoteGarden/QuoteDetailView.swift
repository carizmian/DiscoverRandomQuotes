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
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .font(Font.system(.title3, design: .monospaced).weight(.ultraLight))
            
            
            Text("'\(favoriteQuote.wrappedQuoteText)'")
                .italic()
                .font(Font.system(.title, design: .monospaced).weight(.regular))
                .padding(.horizontal)
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .layoutPriority(2)

            
            
            Text("~ \(favoriteQuote.wrappedQuoteAuthor)")
                .multilineTextAlignment(.center)
                .padding(.top)
                .foregroundColor(.gray)
                .font(Font.system(.title2, design: .serif).weight(.light))
            
        }.padding()

        
    }
}


