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

    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")

    var copyToClipboard: (_ quoteGenre: String, _ quoteText: String, _ quoteAuthor: String) -> Void
    var addToFavorites: (_ id: String, _ text: String, _ author: String, _ genre: String) -> Void

    @Binding var changedQuote: Bool
    @Binding var addedToFavorites: Bool
    @Binding var showingShareSheetView: Bool

    @State private var rect1: CGRect = .zero
    @Binding var uiimage: UIImage?

    var body: some View {

        VStack {

            Color.clear.overlay(

                FlipView(isFlipped: changedQuote) {
                    QuoteView(genre: "\(quote.quoteGenre)", text: "\(quote.quoteText)", author: "\(quote.quoteAuthor)")
                        .layoutPriority(2)
                        .edgesIgnoringSafeArea(.all)
                } back: {
                    QuoteView(genre: "\(quote.quoteGenre)", text: "\(quote.quoteText)", author: "\(quote.quoteAuthor)")
                        .layoutPriority(2)
                        .edgesIgnoringSafeArea(.all)
                }.animation(.spring(response: 0.35, dampingFraction: 0.7))
                .onTapGesture {
                    changedQuote.toggle()

                    quoteGardenApi().getRandomQuote { quote in

                        self.quote = quote
                        addedToFavorites = false
                        self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)

                    }
                }

            )
            .background(RectGetter(rect: $rect1))
            #warning("tek iz drugog button pressa se capture uiimage!")
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
                    copyToClipboard(_: quote.quoteGenre, quote.quoteText, quote.quoteAuthor )
                }) {
                    Image(systemName: "doc.on.doc")
                        .accessibilityLabel(Text("Copy quote"))

                }.buttonStyle(ColoredButtonStyle())

                Button(action: {
                    self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
                    addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre)
                }) {
                    Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                        .accessibilityLabel(Text("Add quote to your favorites"))

                }.buttonStyle(ColoredButtonStyle())

            }

        }
    }
}

//struct QuoteGeneratorView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteGeneratorView()
//    }
//}
