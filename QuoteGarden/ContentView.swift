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
    @State private var savedToDevice = false
    @State private var showingShareSheetView = false
    
    var body: some View {
            
            TabView(selection: $selectedView) {

                QuoteGeneratorView(savedToDevice: $savedToDevice, showingShareSheetView: $showingShareSheetView)
                    .tag(QuoteGeneratorView.tag)
                    .tabItem {
                        Label("Random", systemImage: "text.quote")
                            .accessibilityLabel(Text("New Quote"))
                    }
                
                QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes)
                    .tag(QuoteListView.tag)
                    .tabItem {
                        Label("Saved", systemImage: "bookmark.fill")
                            .accessibilityLabel(Text("Your saved quotes"))
                    }
                
            }
        
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
