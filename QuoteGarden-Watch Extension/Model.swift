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
    let statusCode: Int
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

        let url = URL(fileURLWithPath: "/Users/Nikola/Desktop/QuoteGarden/Watch\\ Extension/quotes.json")
        
        if let data = try? Data(contentsOf: url) {
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                completion(response.quote)
            }

            print(String(data: data, encoding: .utf8)!)
        }

    }

}
