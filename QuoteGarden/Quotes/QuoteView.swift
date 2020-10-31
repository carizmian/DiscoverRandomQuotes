//
//  QuoteView.swift
//  QuoteGarden
//
//  Created by Master Family on 08/10/2020.
//

import SwiftUI

struct QuoteView: View {

    var genre: String
    var text: String
    var author: String

    var body: some View {

        VStack(alignment: .center) {

            HStack {
                Text("#")
                    .foregroundColor(.green)
                Text("\(genre)")
            }.padding(.bottom)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .monospaced).weight(.bold))
            .accessibilityLabel(Text("quote genre is hashtag \(genre)"))

            Text("\(text)")
                .italic()
                .font(Font.system(.title, design: .monospaced).weight(.black))
                .padding(.horizontal)
                .allowsTightening(true)
                .layoutPriority(2)
                .minimumScaleFactor(0.3)
                .accessibilityLabel(Text("quote text is \(text)"))

            HStack {
                Text("~")
                    .foregroundColor(.green)
                Text("\(author)")

            }.padding(.top)
            .allowsTightening(true)
            .font(Font.system(.callout, design: .monospaced).weight(.bold))
            .accessibilityLabel(Text("quote author is \(author)"))

        }.multilineTextAlignment(.center)
        .padding(.top)

    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {

        Group {

            QuoteView(genre: "nature", text: "Human beings are accustomed  ", author: "Edward Thorndike")
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max")

        }
    }
}
