//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    @State private var searchText = ""
    
    
    var body: some View {
        
        TabView {
            
            VStack {
                Text("#\(quote.quoteGenre)")
                HStack {
                    Text("'\(quote.quoteText)'")
                        .italic()
                        .bold()
                    Text("~\(quote.quoteAuthor)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                
                
                
                
                Button(action: { quoteGardenApi().getRandomQuote { (quote) in
                    self.quote = quote
                } }) {
                    Text("New quote")
                }
                
                
                
                
                Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                    Text("Add to favorites")
                }
                
            }.tabItem {
                Image(systemName: "gift.fill")
                    .renderingMode(.original)
                Text("Random")
            }
            
            
            List {
                ForEach(favoriteQuotes, id: \.id) { favoriteQuote in
                    Text(favoriteQuote.quoteText ?? "No Favorite Quote Yet")
                }.onDelete(perform: removeQuote)
            }.tabItem {
                Image(systemName: "bookmark.fill")
                    .renderingMode(.original)
                Text("Favorites")
            }
        }
    }
    
    func addToFavorites(_ id: String, _ text: String, _ author: String, _ genre: String) {
        let favoriteQuote = QuoteCD(context: self.moc)
        favoriteQuote.id = id
        favoriteQuote.quoteText = text
        favoriteQuote.quoteAuthor = author
        favoriteQuote.quoteGenre = genre
        
        try? self.moc.save()
    }
    
    func removeQuote(at offsets: IndexSet) {
        for index in offsets {
            let favoriteQuote = favoriteQuotes[index]
            moc.delete(favoriteQuote)
        }
        
        do {
            try moc.save()
        } catch  {
            return
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


