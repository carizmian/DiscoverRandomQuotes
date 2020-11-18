//
//  QuoteRowView.swift
//  QuoteGarden
//
//  Created by Master Family on 17/10/2020.
//

import SwiftUI

struct QuoteRowView: View {

    var favoriteQuote: QuoteCD

    var body: some View {

        HStack {
            Text("\(favoriteQuote.wrappedQuoteAuthor)")
            Text("#").foregroundColor(.green)
            Text("\(favoriteQuote.wrappedQuoteGenre)")

        }
    }
}
