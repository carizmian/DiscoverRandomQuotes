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
    
    @State private var flipped = false
    
    #warning("Share on social media (copy to clipboard --- minimun)")
    #warning("double tap or swipe down = add to favorites")
    #warning("asscesibilty")
    #warning("widget with your favorite quote")
    
    #warning("Swipe up gesture = new quote")
    @State private var dragOffSet: CGSize = .zero
    
    var body: some View {
        
    
    TabView {
        
        
        
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                VStack {
                    
                    Text("# \(quote.quoteGenre)")
                        .padding()
                        .font(Font.system(.subheadline, design: .serif).weight(.light))
                        .opacity(flipped ? 1 : 0)
                        .offset(x: flipped ? 0 : -400)
                        .animation(.spring())
                    
                    
                    Text("'\(quote.quoteText)'")
                        .italic()
                        .font(Font.system(.title, design: .serif).weight(.ultraLight))
                        .allowsTightening(true)
                        .multilineTextAlignment(.center)
                        .layoutPriority(2)
                        .offset(x: flipped ? 0 : -400)
                        .animation(.spring())
                    
                    
                    
                    
                    Text("~ \(quote.quoteAuthor)")
                        .padding()
                        .foregroundColor(.gray)
                        .font(Font.system(.callout, design: .serif).weight(.black))
                        .opacity(flipped ? 1 : 0)
                        .offset(x: flipped ? 0 : -400)
                        .animation(.spring())
                }
                
            }.animation(.spring())
            .offset(y: self.dragOffSet.height)
            .gesture(DragGesture().onChanged{
                value in
                self.dragOffSet = value.translation
            } .onEnded {
                value in
                self.dragOffSet = .zero
            })
            .padding()
            .onTapGesture(count: 2) {
                addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre)
            }
            .onAppear {
                flipped = true
            }
            
            
            
            
            
            
            
            HStack {
                
                Button(action: { quoteGardenApi().getRandomQuote { (quote) in
                    self.quote = quote
                } }) {
                    VStack {
                        Text("New quote")
                    }.padding()
                    .border(Color.accentColor)
                    
                }.padding()
                
                
                
                
                Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                    
                    VStack {
                        Text("Add to favorites")
                        
                    }.padding()
                    .border(Color.accentColor)
                    
                }
            }
            
            
        }.tabItem {
            Image(systemName: "wand.and.stars")
            Text("Random")
        }
        
        
        NavigationView {
            
            List {
                ForEach(favoriteQuotes, id: \.id) { favoriteQuote in
                    NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote)) {
                        Text(favoriteQuote.quoteText ?? "No Favorite Quote Yet")
                    }
                }.onDelete(perform: removeQuote)
                
                
            }.navigationTitle(Text("Your Favorites"))
            .navigationBarItems(trailing: EditButton())
            
        }.tabItem {
            Image(systemName: "star.fill")
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


