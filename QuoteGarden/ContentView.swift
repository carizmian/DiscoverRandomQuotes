//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation

#warning("haptics")
#warning("use system's sound services for and vibrations")

struct ContentView: View {

    @AppStorage("selectedView") var selectedView: String?

    // Data
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>

    // Booleans
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    // @State private var showButtons = false
    @State private var changedQuote = false

    var body: some View {

        TabView(selection: $selectedView) {

            QuoteGeneratorView(addToFavorites: addToFavorites(_:_:_:_:), changedQuote: $changedQuote, addedToFavorites: $addedToFavorites, showingShareSheetView: $showingShareSheetView)
                .tag(QuoteGeneratorView.tag)
                .tabItem {
                Image(systemName: "wand.and.stars.inverse")
                    .accessibilityLabel(Text("New Quote"))
                Text("Random")
            }

//            RemindersView()
//                .tag(RemindersView.tag)
//                .tabItem {
//                    Image(systemName: "deskclock.fill")
//                        .accessibility(label: Text("Reminder"))
//                    Text("Reminder")
//                }

            QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes)
                .tag(QuoteListView.tag)
            .tabItem {
                Image(systemName: "heart.fill")
                    .accessibilityLabel(Text("Your favorite quotes"))
                Text("Favorites")
            }

        }.accentColor(.purple)
        //        .alert(isPresented: $addedToFavorites) {
        //            Alert(title: Text("Quote added to your favorites"))
        //        }
    }

    func addToFavorites(_ id: String, _ text: String, _ author: String, _ genre: String) {

        let favoriteQuote = QuoteCD(context: self.moc)
        favoriteQuote.id = id
        favoriteQuote.quoteText = text
        favoriteQuote.quoteAuthor = author
        favoriteQuote.quoteGenre = genre

        addedToFavorites = true

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
