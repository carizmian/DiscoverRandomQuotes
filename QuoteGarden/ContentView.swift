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
    @State private var searchText = ""
    
    
    var body: some View {
        VStack {
            
            SearchBar(text: $searchText)
                .onTapGesture {
                    quoteGardenApi().searchAuthor(author: searchText) { (quotes) in
                        self.quotes = quotes
                    }
                }
            
            LazyVStack {
                List(quotes.filter({ searchText.isEmpty ? true : $0.quoteAuthor.contains(searchText) }), id: \.id) { quote in
                    Text(quote.quoteText)
                    Text(quote.quoteAuthor)
                }.onAppear {
                    quoteGardenApi().getAllQuotes() { (quotes) in
                        self.quotes = quotes
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


