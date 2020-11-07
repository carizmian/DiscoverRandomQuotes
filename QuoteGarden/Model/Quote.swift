//
//  Quote.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import Foundation
import Network

// MARK: - Response
struct Response: Decodable {
    let statusCode: Int
    let quote: Quote
}

// MARK: - Quote
struct Quote: Decodable, Hashable {
    let id, quoteText, quoteAuthor, quoteGenre: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quoteText, quoteAuthor, quoteGenre
    }
}
