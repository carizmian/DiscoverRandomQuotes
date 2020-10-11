//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation

#warning("widget")
#warning("share button")
#warning("notifications")

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    @State private var addedToFavorites = false
        
    var body: some View {
        
        
        TabView {
            
            
            VStack {
                
                
                QuoteView(quoteGenre: "\(quote.quoteGenre)", quoteText: "\(quote.quoteText)", quoteAuthor: "\(quote.quoteAuthor)")
                    .animation(.default)
                    
                Spacer()
                
                HStack {
                    
                    Button(action: { quoteGardenApi().getRandomQuote { (quote) in
                        addedToFavorites = false
                        self.quote = quote
                    } }) {

                            Text("New quote")
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(40)
                        
                    }.padding(.bottom)
                    

                    Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                        
                            Text("Add to favorites")
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.blue]), startPoint: .trailing, endPoint: .leading))
                                .foregroundColor(.white)
                                .cornerRadius(40)
                                .offset(y: addedToFavorites ? 400 : 0)
                                .animation(Animation.easeOut(duration: 1))
     
                        
                    }.padding([.leading, .bottom])
                    
                }
                
                
            }.tabItem {
                Image(systemName: "wand.and.stars")
                Text("Random")
            }
            
            
            NavigationView {
                
                List {
                    ForEach(favoriteQuotes, id: \.id) { favoriteQuote in
                        NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote)) {
                            Text("~ \(favoriteQuote.wrappedQuoteAuthor)")
                        }
                    }.onDelete(perform: removeQuote)
                    
                    
                }.navigationTitle(Text("Your Favorites"))
                .navigationBarItems(trailing: EditButton())
                
                
            }.tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            
        }.accentColor(.purple)
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
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



