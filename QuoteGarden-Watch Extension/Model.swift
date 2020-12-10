//
//  Quote.swift
//  QuoteGarden
//
//  Created by Master Family on 08/12/2020.
//

import Foundation
import Network

// MARK: - Response
struct Response: Codable {
    let quote: Quote
}

// MARK: - Quote
struct Quote: Codable, Hashable {
    var id, quoteText, quoteAuthor, quoteGenre: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quoteText, quoteAuthor, quoteGenre
    }
}

struct QuoteGardenApi {
    
    func getRandomQuote(completion: @escaping (Quote) -> Void) {
        
        let config = URLSessionConfiguration.default
        config.allowsExpensiveNetworkAccess = true
        config.allowsConstrainedNetworkAccess = true
        config.allowsCellularAccess = true
        config.waitsForConnectivity = false
//        config.requestCachePolicy = .reloadIgnoringLocalCacheData

        let url = URL(string: "https://quote-garden.herokuapp.com/api/v2/quotes/random")

        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession(configuration: config).dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }

            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                print(String(describing: error))
                return
            }
            DispatchQueue.main.async {
                completion(response.quote)
            }

            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
}
