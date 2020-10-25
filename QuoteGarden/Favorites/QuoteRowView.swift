//
//  QuoteRowView.swift
//  QuoteGarden
//
//  Created by Master Family on 17/10/2020.
//

import SwiftUI

struct QuoteRowView: View {

    var quoteGenre: String
    var quoteAuthor: String

    var body: some View {

        HStack {
            Text("~ \(quoteAuthor)")
                .padding(.trailing)

            Text("# \(quoteGenre)")

        }.foregroundColor(.accentColor)

    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteRowView(quoteGenre: "# science", quoteAuthor: " ~ Leslie Fiedler")
    }
}
