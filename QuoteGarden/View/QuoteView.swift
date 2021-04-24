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

        #if os(iOS)
            VStack(alignment: .center) {

                HStack {
                    Text("#")
                    Text("\(quote.quoteGenre)")
                }.padding(.bottom)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .accessibility(value: Text("quote genre is hashtag \(quote.quoteGenre)"))

                Text("\(quote.quoteText)")
                    .italic()
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibility(value: Text("quote text is \(quote.quoteText)"))

                HStack {
                    Text("~")
                    Text("\(quote.quoteAuthor)")

                }.padding(.top)
                .allowsTightening(true)
                .font(Font.system(.callout, design: .monospaced).weight(.bold))
                .accessibility(value: Text("quote author is \(quote.quoteAuthor)"))

            }
            .foregroundColor(Color("TextColor"))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color("AccentColor").clipShape(RoundedRectangle(cornerRadius: 25)))
        #elseif os(watchOS)
        VStack(alignment: .leading) {

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
        #endif
        
    }
}
