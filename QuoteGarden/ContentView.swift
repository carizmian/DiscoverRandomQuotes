//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation


struct ContentView: View {
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević")
    @State private var searchText = ""
    
    #warning("napravi da jedan quote po jedan gledas i da je random i da ga mores lajkat i to je to")
    #warning("Favorites using CoreData")
    
    var body: some View {
        VStack {
                HStack {
                    Text("'\(quote.quoteText)'")
                        .italic()
                        .bold()
                    Text("~\(quote.quoteAuthor)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }.animation(.interpolatingSpring(mass: 1.9, stiffness: 2.2, damping: 2.2, initialVelocity: 5.2))
            
            //  SearchBar(text: $searchText)
            
            Button(action: { quoteGardenApi().getRandomQuote { (quote) in
                self.quote = quote
            } }) {
                Text("Random")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


