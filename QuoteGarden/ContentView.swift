//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation


struct ContentView: View {
    
   @State private var quotes: [Quote] = []
    
    
    var body: some View {
        List(quotes, id: \.id) { quote in
            Text(quote.quoteText)
            Text(quote.quoteAuthor)
        }.onAppear {
            quoteGardenApi().getAllQuotes { (quotes) in
                self.quotes = quotes
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


