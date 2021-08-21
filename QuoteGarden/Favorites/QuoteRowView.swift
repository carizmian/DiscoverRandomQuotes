import SwiftUI

struct QuoteRowView: View {
    
    var favoriteQuote: QuoteCD
    
    var body: some View {
        
        HStack {
                Text("\(favoriteQuote.wrappedQuoteAuthor)")
                    .accessibility(value: Text("quote author is \(favoriteQuote.wrappedQuoteAuthor)"))
                Text("#")
                Text("\(favoriteQuote.wrappedQuoteGenre)")
                    .accessibility(value: Text("quote genre is \(favoriteQuote.wrappedQuoteGenre)"))
        }.font(Font.system(.body, design: .rounded).weight(.regular))
    }
}
