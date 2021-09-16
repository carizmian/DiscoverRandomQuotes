import Foundation

class QuoteViewModel: ObservableObject {
  @Published var quotes: [Quote] = Array()
  @Published var quote = Quote.example
  // MARK: - Screenshots
  //    @Published var quote = Quote(id: "", quoteText: "Success usually comes to those who are too busy looking for it", quoteAuthor: "Henry David Thoreau", quoteGenre: "motivation")
  init() {
    print("initialising QuoteViewModel")
  }
  func getRandomQuote() {
    let randomPage = Int.random(in: 1..<2)
    let randomQuote = Int.random(in: 0..<36335)
    #warning("Handle the possible URL error")
    let url = Bundle.main.url(forResource: "quotes\(randomPage).json", withExtension: nil)
    URLSession.shared.dataTask(with: url!) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
        print(String(describing: error))
        return
      }
      DispatchQueue.main.async {
        self.quote = response.data[randomQuote]
      }
    }
    .resume()
  }
  func getRandomQuotes(withCompletionHandler completionHandler: @escaping ([Quote]) -> Void) {
    let randomPage = Int.random(in: 1..<2)
    var randomQuote = Int.random(in: 0..<36335)
    let url = Bundle.main.url(forResource: "quotes\(randomPage).json", withExtension: nil)
    URLSession.shared.dataTask(with: url!) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
        print(String(describing: error))
        return
      }
      DispatchQueue.main.async {
        // Appends 64 quotes
        for _ in 1...64 {
          self.quotes.append(response.data[randomQuote])
          randomQuote = Int.random(in: 0..<36335)
        }
        completionHandler(self.quotes)
      }
    }
    .resume()
  }
  func changeQuote(_ quote: Quote) {
    self.quote = quote
  }
}
