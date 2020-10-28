//
//  QuoteGeneratorView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI
import Foundation

struct QuoteGeneratorView: View {

    static let tag: String? = "Home"

    @EnvironmentObject var network: NetworkMonitor

    @State private var quote: Quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")

    var addToFavorites: (_ id: String, _ text: String, _ author: String, _ genre: String) -> Void

    @Binding var changedQuote: Bool
    @Binding var addedToFavorites: Bool
    @State private var addedToClipboard = false
    @Binding var showingShareSheetView: Bool

    @State private var rect1: CGRect = .zero
    @State private var uiimage: UIImage?

    var body: some View {

        VStack {

            Color.clear.overlay(

                QuoteView(genre: "\(quote.quoteGenre)", text: "\(quote.quoteText)", author: "\(quote.quoteAuthor)")
                    .layoutPriority(2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        changedQuote.toggle()

                        QuoteGardenApi().getRandomQuote { quote in

                            self.quote = quote
                            addedToFavorites = false
                            addedToClipboard = false

                        }

                        self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)

                    }
                    .animation(.default)

            )
            .background(RectGetter(rect: $rect1))

            HStack {
                Button(action: {
                    print(self.uiimage.debugDescription)
                    self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
                    if self.uiimage != nil {
                        showingShareSheetView = true
                        print(self.uiimage.debugDescription)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .accessibilityLabel(Text("Share quote"))

                }.buttonStyle(ColoredButtonStyle())

                Button(action: {
                    self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
                    addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre)
                }) {
                    Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                        .accessibilityLabel(Text("Add quote to your favorites"))

                }.buttonStyle(ColoredButtonStyle())

                Button(action: {
                    self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
                    copyToClipboard(quoteGenre: quote.quoteGenre, quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor)
                }) {
                    Image(systemName: addedToClipboard ? "doc.on.doc.fill" : "doc.on.doc")
                        .accessibilityLabel(Text("Copy quote"))

                }.buttonStyle(ColoredButtonStyle())

            }

        }.animation(.default)
        .sheet(isPresented: $showingShareSheetView) {
            if uiimage != nil {
                ShareSheetView(activityItems: [
                    self.uiimage!
                ])
            }
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

        addedToClipboard = true
    }
}

//struct QuoteGeneratorView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteGeneratorView()
//    }
//}
