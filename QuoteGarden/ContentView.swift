//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation

// TODO: Implement haptics, vibrations and sound

struct ContentView: View {
    
    @AppStorage("selectedView") var selectedView: String?
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    
    var body: some View {
            
            TabView(selection: $selectedView) {
                
                QuoteGeneratorView(addToFavorites: addToFavorites(_:_:_:_:), addedToFavorites: $addedToFavorites, showingShareSheetView: $showingShareSheetView)
                    .tag(QuoteGeneratorView.tag)
                    .tabItem {
                        Label("Random", systemImage: "text.quote")
                            .accessibilityLabel(Text("New Quote"))
                    }
                    .transition(.slide)
                
                QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes)
                    .tag(QuoteListView.tag)
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                            .accessibilityLabel(Text("Your favorite quotes"))
                    }
                
            }
        
    }
    func addToFavorites(_ id: String, _ text: String, _ author: String, _ genre: String) {
        // FIXME: User can delete object when he taps the favorite button again (toggle)
        
        addedToFavorites = true
        
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
        } catch {
            return
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
