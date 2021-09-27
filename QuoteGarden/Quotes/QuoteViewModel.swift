import Foundation

class QuoteViewModel: ObservableObject {
  let speechManager = SpeechManager.shared
  @Published var quotes: [Quote] = Array()
  @Published private(set) var quote = Quote.help
  init() {
    print("initialising QuoteViewModel")
  }
  deinit {
    print("deinitialising QuoteViewModel")
  }
  func fetchQuote() {
    speechManager.resetState()
    self.emptyQuote()
    let randomPage = Int.random(in: 1..<2)
    let randomQuote = Int.random(in: 0..<36335)
    guard let url = Bundle.main.url(forResource: "quotes\(randomPage).json", withExtension: nil) else {
      print("Invalid URL!")
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else {
        print("data: " + String(describing: error))
        return
      }
      guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
        print("response: " + String(describing: error))
        return
      }
      DispatchQueue.main.async {
        self.quote = response.data[randomQuote]
      }
    }
    .resume()
  }
  func fetchQuotes(withCompletionHandler completionHandler: @escaping ([Quote]) -> Void) {
    speechManager.resetState()
    let randomPage = Int.random(in: 1..<2)
    var randomQuote = Int.random(in: 0..<36335)
    guard let url = Bundle.main.url(forResource: "quotes\(randomPage).json", withExtension: nil) else {
      print("Invalid URL!")
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else {
        print("data: " + String(describing: error))
        return
      }
      guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
        print("response: " + String(describing: error))
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
  func updateQuote(with quote: Quote) {
    self.quote = quote
    speechManager.resetState()
  }
  private func emptyQuote() {
    quote = Quote(id: "", text: "", author: "", genre: "")
  }
}
