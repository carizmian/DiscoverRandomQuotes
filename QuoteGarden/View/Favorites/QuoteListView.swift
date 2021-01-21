//
//  QuoteListView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI
import Foundation

struct QuoteListView: View {
    
    static let tag: String? = "Saved Quotes"
    
    @Environment(\.managedObjectContext) var moc
    var removeQuote: (IndexSet) -> Void
    var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                ShakableViewRepresentable()
                    .allowsHitTesting(false)
                VStack {
                    SearchBar(text: $searchText)
                        .padding(.top, 8)
                    
                    List {
                        
                        ForEach(favoriteQuotes.filter({ searchText.isEmpty ? true : $0.wrappedQuoteAuthor.contains(searchText) }), id: \.id) { favoriteQuote in
                            NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote)) {
                                
                                HStack {
                                    QuoteRowView(favoriteQuote: favoriteQuote)
                                    
                                }
                                
                            }
                        }.onDelete(perform: removeQuote)
                        
                        
                        
                        
                    }.listStyle(PlainListStyle())
                    .navigationBarTitle(Text("Your Saved Quotes"))
                    .navigationBarItems(trailing: EditButton())
                    .edgesIgnoringSafeArea(.bottom)
                    
                }.onReceive(messagePublisher) { _ in
                   // moc.undoManager = UndoManager()
                    print(moc.undoManager?.canUndo ?? "error")
                    moc.undo()
                    print("Shaking")
                }
                
            }
            
        }
        
    }
    
    
}
//struct QuoteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteListView()
//    }
//}
