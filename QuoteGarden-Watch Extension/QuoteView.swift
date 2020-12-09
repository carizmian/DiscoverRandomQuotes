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

            VStack(alignment: .center) {

                HStack {
                    Text("#")
                        .foregroundColor(.green)
                    Text("\(quote.quoteGenre)")
                }.padding(.bottom, 1)
                .allowsTightening(true)
                .accessibility(value: Text("quote genre is hashtag \(quote.quoteGenre)"))

                Text("\(quote.quoteText)")
                    .foregroundColor(.pink)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.2)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))

                HStack {
                    Text("~")
                        .foregroundColor(.green)
                    Text("\(quote.quoteAuthor)")

                }.padding(.top, 1)
                .allowsTightening(true)
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

            }.multilineTextAlignment(.center)
            
    }
}
