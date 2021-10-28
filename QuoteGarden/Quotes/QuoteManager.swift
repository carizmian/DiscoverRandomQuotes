import Foundation

class QuoteViewModel: ObservableObject {
  @Published var quote = Quote.help
  func changeQuote(_ quote: Quote) {
    self.quote = quote
  }
}
