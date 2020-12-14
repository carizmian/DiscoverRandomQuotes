//
//  QuoteView.swift
//  QuoteGarden
//
//  Created by Master Family on 08/12/2020.
//

import SwiftUI

struct QuoteView: View {

    var quote: Quote

    var body: some View {

        VStack(alignment: .leading) {

//                HStack {
//                    Text("#")
//                        .foregroundColor(.green)
//                    Text("\(quote.quoteGenre)")
//                }.padding(.bottom, 1)
//                .allowsTightening(true)
//                .accessibility(value: Text("quote genre is hashtag \(quote.quoteGenre)"))

                Text("\(quote.quoteText)")
                    .foregroundColor(.accentColor)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.7)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))
                HStack {
                    Text("~")
                        .foregroundColor(.green)
                    Text("\(quote.quoteAuthor)")

                }.padding(.top, 1)
                .allowsTightening(true)
                .font(.footnote)
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

        }.multilineTextAlignment(.leading)
        .edgesIgnoringSafeArea(.all)
            
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quote: Quote.init(id: "", quoteText: "This is just for a test, because I do not know any quote by hea", quoteAuthor: "Nikola Franičević", quoteGenre: "test"))
            .previewDevice("Apple Watch Series 5 - 40mm")
    }
}
