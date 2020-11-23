//
//  QuoteListView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI

struct QuoteListView: View {
    
    static let tag: String? = "Saved Quotes"
    
    var removeQuote: (IndexSet) -> Void
    var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                List {
                    
                    ForEach(favoriteQuotes.filter({ searchText.isEmpty ? true : $0.wrappedQuoteAuthor.contains(searchText) }), id: \.id) { favoriteQuote in
                        NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote)) {
                            
                            HStack {
                                QuoteRowView(favoriteQuote: favoriteQuote)
                            }
                            
                        }
                    }.onDelete(perform: removeQuote)
                    
                }.listStyle(InsetListStyle())
                .navigationBarTitle(Text("Your Saved Quotes"))
                .navigationBarItems(trailing: EditButton())
                .edgesIgnoringSafeArea(.bottom)
                
            }
            
        }
    }
}
//struct QuoteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteListView()
//    }
//}
