import Foundation

class QuoteViewModel: ObservableObject {
    @Published var quotes = [Quote]()
    #warning("Tap here or shake your device to generate a random quote!")
    @Published var quote = Quote(id: "", quoteText: "Tap here to generate a random quote", quoteAuthor: "Nikola Franičević", quoteGenre: "help")
    
    
    
    func getRandomQuote() {
        let randomPage = Int.random(in: 1..<2)
        let randomQuote = Int.random(in: 0..<36335)
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
        }.resume()
        
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
                // Appends 500 quotes
                for _ in 1...500 {
                    self.quotes.append(response.data[randomQuote])
                    randomQuote = Int.random(in: 0..<36335)
                }
                completionHandler(self.quotes)
            }
        }.resume()
        
    }
    
    func changeQuote(_ quote: Quote) {
        self.quote = quote
        
    }
}
