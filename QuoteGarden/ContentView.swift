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
#warning("swift lint")

//Secondary
#warning("app clip")
#warning("spotlight indexing")

struct ContentView: View {

    // Data
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>

    var userDefaults = UserDefaults.init()

    // Booleans
    @State private var addedToFavorites = false
    @State private var showingShareSheetView = false
    // @State private var showButtons = false
    @State private var changedQuote = false

    // Other
    @State private var uiimage: UIImage?

    var body: some View {

        TabView {

//            VStack {
//
//                Color.clear
//                    .overlay (
//
//                        QuoteView(genre: "\(quote.quoteGenre)", text: "\(quote.quoteText)", author: "\(quote.quoteAuthor)")
//                            .layoutPriority(2)
//                            .edgesIgnoringSafeArea(.all)
//                            .rotation3DEffect(changedQuote ? Angle(degrees: 360) : Angle(degrees: 0), axis: (x: 0, y: 1, z: 0))
//                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                                        .onEnded({ value in
//
//                                            if value.translation.width < 0 {
//                                                withAnimation(Animation.easeOut(duration: 1)) {
//                                                    changedQuote.toggle()
//                                                }
//                                                quoteGardenApi().getRandomQuote { quote in
//                                                    withAnimation(.default) {
//                                                        addedToFavorites = false
//                                                    }
//                                                }
//                                            }
//                                        }))
//
//                    )
//                    .background(RectGetter(rect: $rect1))
//                    .onAppear{
//                        self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
//                    }

                // The cool popup
                //                Group {
                //
                //                    HStack {
                //                        Button(action: { showingShareSheetView = true }) {
                //                            Image(systemName: "square.and.arrow.up")
                //                                .accessibilityLabel(Text("Share quote"))
                //                                .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                //
                //                        }.customCircleButtonStyle()
                //                        .offset(x: showButtons ? 0 : 0, y: showButtons ? 0 : 50)
                //                        .opacity(showButtons ? 1 : 0)
                //
                //                        Button(action: { copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor )}) {
                //                            Image(systemName: "doc.on.doc")
                //                                .accessibilityLabel(Text("Copy quote"))
                //                                .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                //
                //
                //                        }.customCircleButtonStyle()
                //                        .offset(x: showButtons ?  0 : 0, y: showButtons ? 0 : 50)
                //                        .opacity(showButtons ? 1 : 0)
                //
                //
                //                        Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                //                            Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                //                                .accessibilityLabel(Text("Add quote to your favorites"))
                //                                .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                //
                //                        }.customCircleButtonStyle()
                //                        .offset(x: showButtons ?  0 : 0, y: showButtons ? 0 : 50)
                //                        .opacity(showButtons ? 1 : 0)
                //
                //                    }
                //
                //
                //                    Button(action: { showButtons.toggle() }) {
                //                        Image(systemName: "plus")
                //                            .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
                //                            .padding(.horizontal)
                //                    }.customCapsuleButtonStyle()
                //                    .overlay(
                //                        Capsule()
                //                            .stroke(Color.purple, lineWidth: 4)
                //                            .scaleEffect(showButtons ? 2 : 1)
                //                            .opacity(showButtons ? 0 : 1))
                //                    .animation(Animation.easeOut(duration: 0.6))
                //
                //
                //
                //                }.padding()
                //                .animation(.default)

//                HStack {
//                    Button(action: { showingShareSheetView = true }) {
//                        Image(systemName: "square.and.arrow.up")
//                            .accessibilityLabel(Text("Share quote"))
//
//                    }.customCircleButtonStyle()
//
//
//                    Button(action: { copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor )}) {
//                        Image(systemName: "doc.on.doc")
//                            .accessibilityLabel(Text("Copy quote"))
//
//
//
//                    }.customCircleButtonStyle()
//
//
//
//                    Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
//                        Image(systemName: addedToFavorites ? "heart.fill" : "heart")
//                            .accessibilityLabel(Text("Add quote to your favorites"))
//
//                    }.customCircleButtonStyle()
//
//
//                }
//          }.font(.title)
            QuoteGeneratorView(copyToClipboard: copyToClipboard(quoteGenre:quoteText:quoteAuthor:), addToFavorites: addToFavorites(_:_:_:_:), changedQuote: $changedQuote, addedToFavorites: $addedToFavorites, showingShareSheetView: $showingShareSheetView, uiimage: $uiimage)
                .tabItem {
                Image(systemName: "wand.and.stars")
                    .accessibilityLabel(Text("New Quote"))
                Text("Random")
            }

            RemindersView()
                .tabItem {
                    Image(systemName: "deskclock.fill")
                        .accessibility(label: Text("Reminder"))
                    Text("Reminder")
                }

            QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes)
            .tabItem {
                Image(systemName: "heart.fill")
                    .accessibilityLabel(Text("Your favorite quotes"))
                Text("Favorites")
            }

        }.accentColor(.purple)
        .sheet(isPresented: $showingShareSheetView) {
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
        } catch {
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
