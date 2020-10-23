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



extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

struct RectGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }

    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    @State private var quoteSelectedForWidget = false
    
    @State private var searchText = ""
    
    var userDefaults = UserDefaults.init()
    
    @State private var showButtons = false
    
    @State private var changedQuote = false
    
    //get image
    
    @State private var rect1: CGRect = .zero
    @State private var rect2: CGRect = .zero
    @State private var uiimage: UIImage? = nil
    
    
    var body: some View {
        
        TabView {
            
            ZStack(alignment: .center) {
                
                VStack {
                    
                    #warning("swipe right for new quote")
                    QuoteView(quoteGenre: "\(quote.quoteGenre)", quoteText: "\(quote.quoteText)", quoteAuthor: "\(quote.quoteAuthor)")
                        .layoutPriority(2)
                        .edgesIgnoringSafeArea(.all)
                        .rotation3DEffect(changedQuote ? Angle(degrees: 360) : Angle(degrees: 0), axis: (x: 0, y: 1, z: 0))
                        .onTapGesture(count: 2) {
                            
                            withAnimation(Animation.easeOut(duration: 1)) {
                                changedQuote.toggle()
                            }
                            
                            quoteGardenApi().getRandomQuote { quote in
                                withAnimation(.default) {
                                    addedToFavorites = false
                                }
                                self.quote = quote
                                userDefaults.setValue(self.quote.quoteGenre, forKey: "qg")
                                userDefaults.setValue(self.quote.quoteText, forKey: "qt")
                                userDefaults.setValue(self.quote.quoteAuthor, forKey: "qa")
                                #warning("user defaults for the last loaded quote")
                            }
                        }
                        .background(RectGetter(rect: $rect1))
                        .onTapGesture {
                            self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
                        }

                }
     
                // The cool popup
                Group {
                    
                    
                    Button(action: { showingShareSheetView = true }) {
                        Image(systemName: "square.and.arrow.up")
                            .accessibilityLabel(Text("Share quote"))
                            .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                        
                    }.customCircleButtonStyle()
                    .offset(x: 0, y: showButtons ? -150 : 0)
                    .opacity(showButtons ? 1 : 0)
                    
                    Button(action: { copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor )}) {
                        Image(systemName: "doc.on.doc")
                            .accessibilityLabel(Text("Copy quote"))
                            .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                        
                        
                    }.customCircleButtonStyle()
                    .offset(x: showButtons ? -110 : 0, y: showButtons ? -110 : 0)
                    .opacity(showButtons ? 1 : 0)
                    
                    
                    Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                        Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                            .accessibilityLabel(Text("Add quote to your favorites"))
                            .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                        
                    }.customCircleButtonStyle()
                    .offset(x: showButtons ? -150 : 0, y: 0)
                    .opacity(showButtons ? 1 : 0)
                    
                    
                    
                    
                    Button(action: { showButtons.toggle() }) {
                        Image(systemName: "plus")
                            .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
                    }.customCircleButtonStyle()
                    .overlay(
                        Capsule()
                            .stroke(Color.purple, lineWidth: 4)
                            .scaleEffect(showButtons ? 2 : 1)
                            .opacity(showButtons ? 0 : 1))
                    .animation(Animation.easeOut(duration: 0.6))
                    
                    
                    
                }.padding(.trailing)
                .animation(.linear)
                
            
                
            }.font(.title)
            .tabItem {
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
            if uiimage != nil {
            ShareSheetView(activityItems: [
                self.uiimage!
            ])
            }
        }
        //        .alert(isPresented: $addedToFavorites) {
        //            Alert(title: Text("Quote added to your favorites"))
        //        }
    }
    
    func addToFavorites(_ id: String, _ text: String, _ author: String, _ genre: String) {
        
        addedToFavorites.toggle()
        
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





