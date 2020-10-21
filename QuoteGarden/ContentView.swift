//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation

// PRIMARY
#warning("accessibility")
#warning("bolji gesturi manje botuna")

//Secondary
#warning("app clip")
#warning("spotlight indexing")




struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    @State private var userStartedDiscovering = false
    @State private var quoteSelectedForWidget = false
    
    @State private var searchText = ""
    
    var body: some View {
        
        
        TabView {
            
            VStack(alignment: .center) {
                
                
                QuoteView(quoteGenre: "\(quote.quoteGenre)", quoteText: "\(quote.quoteText)", quoteAuthor: "\(quote.quoteAuthor)")
                    .layoutPriority(2)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.default)
                    
                
                HStack {
                    
                    if userStartedDiscovering {
                        
                        Group {
                            
                            Button(action: { showingShareSheetView = true }) {
                                Image(systemName: "square.and.arrow.up")
                                    .accessibilityLabel(Text("Share quote"))
                                
                            }.padding(.trailing)
                            
//                            Button(action: { copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor )}) {
//                                Image(systemName: "doc.on.doc")
//                                    .accessibilityLabel(Text("Copy quote"))
//
//                            }.padding([.leading, .trailing])
                            
                            Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                                Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                                    .accessibilityLabel(Text("Add quote to your favorites"))
                                
                                
                            }.disabled(addedToFavorites)
                            .padding([.leading, .trailing])
                            
                        }.transition(.opacity)
                        
                    }
                    
                }.padding(.bottom)
                .font(.largeTitle)
                
                Button(action: { quoteGardenApi().getRandomQuote { (quote) in
                    
                    withAnimation(.default) {
                        userStartedDiscovering = true
                        addedToFavorites = false
                    }
                    self.quote = quote
                } }) {
                    
                    Image(systemName: "wand.and.rays")
                        .accessibilityLabel(Text("New Quote"))

                    
                }.font(.largeTitle)
                

                
                
                
            }.tabItem {
                Image(systemName: "wand.and.stars")
                    .accessibilityLabel(Text("New Quote"))
                Text("Random")
            }
            
            
            
            
            
            VStack {
                RemindersView()
            }.tabItem {
                Image(systemName: "deskclock.fill")
                    .accessibility(label: Text("Reminder"))
                Text("Reminder")
            }
            
            
            
            
            
            
            NavigationView {
                                
                VStack {
                    SearchBar(text: $searchText)
                
                List {
                    ForEach(favoriteQuotes.filter({ searchText.isEmpty ? true : $0.wrappedQuoteAuthor.contains(searchText) }), id: \.id) { favoriteQuote in
                        NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote)) {
                            HStack {
                                QuoteRowView(quoteGenre: favoriteQuote.wrappedQuoteGenre, quoteAuthor: favoriteQuote.wrappedQuoteAuthor)
                            }
                        }
                    }.onDelete(perform: removeQuote)
            
                    
                    
                }.listStyle(InsetListStyle())
                .navigationBarTitle(Text("Your Favorite Quotes"))
                .navigationBarItems(trailing: EditButton())
                .edgesIgnoringSafeArea(.bottom)
                
            }
                
                
            }.tabItem {
                Image(systemName: "heart.fill")
                    .accessibilityLabel(Text("Your favorite quotes"))
                Text("Favorites")
            }
            
        }.accentColor(.purple)
        .sheet(isPresented: $showingShareSheetView) {
            #warning("share-aj image a ne text")
            
            ShareSheetView(activityItems: ["""
            \(quote.quoteGenre)

            \(quote.quoteText)

            \(quote.quoteAuthor)
            """
            ])
        }
        .alert(isPresented: $addedToFavorites) {
            Alert(title: Text("Quote added to your favorites"))
        }
    }
    
    func addToFavorites(_ id: String, _ text: String, _ author: String, _ genre: String) {
        let favoriteQuote = QuoteCD(context: self.moc)
        favoriteQuote.id = id
        favoriteQuote.quoteText = text
        favoriteQuote.quoteAuthor = author
        favoriteQuote.quoteGenre = genre
        
        withAnimation(.default) {
            addedToFavorites = true
        }
        
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
    
//    func copyToClipboard(quoteGenre: String, quoteText: String, quoteAuthor: String) {
//
//        let quoteString = """
//        \(quoteGenre)
//
//        \(quoteText)
//
//        \(quoteAuthor)
//        """
//
//        let pasteboard = UIPasteboard.general
//        pasteboard.string = quoteString
//
//        if pasteboard.string != nil {
//            print(quoteText)
//        }
//    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





