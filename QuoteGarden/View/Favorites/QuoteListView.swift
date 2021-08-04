//
//  QuoteListView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI
import Foundation
import AVFoundation

struct QuoteListView: View {
    static let tag: String? = "Saved Quotes"
    @Environment(\.managedObjectContext) var moc
    var removeQuote: (IndexSet) -> Void
    var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var searchText = ""
    let synthesizer: AVSpeechSynthesizer
    @State private var showingBuyStorageSheetView = false
    @State private var startAnimation = false
    var body: some View {
        //   NavigationView {
        ZStack {
            ShakableViewRepresentable()
                .allowsHitTesting(false)
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top, 8)
                
                List {
                    
                    ForEach(favoriteQuotes.filter({ searchText.isEmpty ? true : $0.wrappedQuoteAuthor.contains(searchText) }), id: \.id) { favoriteQuote in
                        NavigationLink(destination: QuoteDetailView(favoriteQuote: favoriteQuote, synthesizer: synthesizer)) {
                            
                            HStack {
                                QuoteRowView(favoriteQuote: favoriteQuote)
                                
                            }
                            
                        }
                    }.onDelete(perform: removeQuote)
                    
                }.listStyle(PlainListStyle())
                .navigationBarTitle(Text("Your Saved Quotes"))
                .navigationBarItems(trailing: EditButton())
                .edgesIgnoringSafeArea(.bottom)
                
                Button(action: { showingBuyStorageSheetView.toggle() }) {
                    HStack {
                        #warning("ovo treba HIDE! nakon kupnje")
                        Text("\(favoriteQuotes.count)/\(5)")
                        Image(systemName: "cart.fill")
                            .overlay(
                                Image(systemName: "cart.fill")
                                    .scaleEffect(startAnimation ? 1.1 : 1)
                                    .opacity(startAnimation ? 0 : 1))
                            .rotationEffect(Angle(degrees: startAnimation ? 360 : 0))
                            .animation(Animation.easeOut(duration: 0.6)
                                        .delay(3)
                                        .repeatForever(autoreverses: false))
                    }.padding(8)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .foregroundColor(Color("TextColor"))
                    .padding(8)
                }
                
            }.onReceive(messagePublisher) { _ in
                // moc.undoManager = UndoManager()
                print(moc.undoManager?.canUndo ?? "error")
                moc.undo()
                print("Shaking")
            }
            .sheet(isPresented: $showingBuyStorageSheetView) {
                BuyStorageSheetView()
            }
            
        }.onAppear {
            startAnimation.toggle()
        }
        
        //  }
        
    }
    
}
//struct QuoteListView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteListView()
//    }
//}
