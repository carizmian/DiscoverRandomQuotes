//
//  QuoteView.swift
//  QuoteGarden
//
//  Created by Master Family on 08/10/2020.
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
                }.padding(.bottom)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .accessibilityLabel(Text("quote genre is hashtag \(quote.quoteGenre)"))

                Text("\(quote.quoteText)")
                    .italic()
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibilityLabel(Text("quote text is \(quote.quoteText)"))

                HStack {
                    Text("~")
                        .foregroundColor(.green)
                    Text("\(quote.quoteAuthor)")

                }.padding(.top)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .accessibilityLabel(Text("quote author is \(quote.quoteAuthor)"))

            }.multilineTextAlignment(.center)
            .padding()
            .background(Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 25)))
        
    }
}
