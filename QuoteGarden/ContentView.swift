//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation

#warning("widget")
#warning("user can set reminder (tab view)")
#warning("core data checks for duplicate quotes stored")
#warning("iMessage extension, mozda ne treba jer imas share button")
#warning("app clip")
#warning("spotlight indexing")

#warning("long press on favorite quote ~ rate the quote")


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    
    #warning("dovrši unit testing na raywenderlichu")
    
    var body: some View {
        
        
        TabView {
            
            VStack(alignment: .center) {
                
                QuoteView(quoteGenre: "\(quote.quoteGenre)", quoteText: "\(quote.quoteText)", quoteAuthor: "\(quote.quoteAuthor)")
                    .animation(.default)
                    .layoutPriority(2)
                    .edgesIgnoringSafeArea(.all)
                
                Spacer()
                
                HStack {
                    
                    Button(action: { showingShareSheetView = true }) {
                        Image(systemName: "square.and.arrow.up")
                            .accessibilityLabel(Text("Share quote"))
                          
                    }
                    
                    Button(action: { copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor )}) {
                        Image(systemName: "doc.on.doc")
                            .accessibilityLabel(Text("Copy quote"))
                        
                    }
                    
                    Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                        Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                            .accessibilityLabel(Text("Add quote to your favorites"))
                        
                    }.disabled(addedToFavorites)
                    
                }
                                
                
                Button(action: { quoteGardenApi().getRandomQuote { (quote) in
                    addedToFavorites = false
                    self.quote = quote
                } }) {
                    
                    Image(systemName: "wand.and.rays").accessibilityLabel(Text("New Quote"))
                    
                }.padding(.bottom)
                
                
            }.tabItem {
                Image(systemName: "wand.and.stars")
                    .accessibilityLabel(Text("New Quote"))
                Text("Random")
            }
            
            
            
            
            NavigationView {
                
                List {
                    ForEach(favoriteQuotes, id: \.id) { favoriteQuote in
                        NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote)) {
                            Text("~ \(favoriteQuote.wrappedQuoteAuthor)")
                        }
                    }.onDelete(perform: removeQuote)
                    
                    
                }.navigationBarTitle(Text("Your Favorite Quotes"))
                .navigationBarItems(trailing: EditButton())
                
                
            }.tabItem {
                Image(systemName: "heart.fill")
                    .accessibilityLabel(Text("Your favorite quotes"))
                Text("Favorites")
            }
            
        }.accentColor(.purple)
        .sheet(isPresented: $showingShareSheetView) {
            ShareSheetView(activityItems: ["""
            \(quote.quoteGenre)

            \(quote.quoteText)

            \(quote.quoteAuthor)
            """
            ])
        }
    }
    
    /// saves to Core Data
    /// - Parameters:
    ///   - id: id is a string
    ///   - text: the text of the quote
    ///   - author: the author of the quote
    ///   - genre: the genre of the quote
    
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
        } catch  {
            return
        }
    }
    
    func copyToClipboard(quoteGenre: String, quoteText: String, quoteAuthor: String) {
        
        let quoteString = """
        \(quoteGenre)

        \(quoteText)

        \(quoteAuthor)
        """
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = quoteString
        
        if pasteboard.string != nil {
            print(quoteText)
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



