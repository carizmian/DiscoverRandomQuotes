import SwiftUI

struct QuoteRowView: View {
  var savedQuote: SavedQuote
  var body: some View {
    HStack {
      Text("\(savedQuote.wrappedAuthor)")
        .accessibility(value: Text("quote author is \(savedQuote.wrappedAuthor)"))
      Text("#\(savedQuote.wrappedGenre)")
        .accessibility(value: Text("quote genre is \(savedQuote.wrappedGenre)"))
    }.font(Font.system(.body, design: .rounded).weight(.regular))
  }
}
