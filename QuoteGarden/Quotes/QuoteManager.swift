import Foundation

class QuoteViewModel: ObservableObject {
  @Published var quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
  func changeQuote(_ quote: Quote) {
    self.quote = quote
  }
}
