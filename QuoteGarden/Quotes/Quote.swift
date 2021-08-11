import Foundation
 
// MARK: - Response
struct Response: Codable {
    let statusCode: Int
    let data: [Quote]
}

// MARK: - Quote
struct Quote: Codable, Hashable {
    var id, quoteText, quoteAuthor, quoteGenre: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quoteText, quoteAuthor, quoteGenre
    }
}

func getRandomQuote(completion: @escaping (Quote) -> Void) {
    
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
            completion(response.data[randomQuote])
        }
        //print(String(data: data, encoding: .utf8)!)
    }.resume()
    
}
