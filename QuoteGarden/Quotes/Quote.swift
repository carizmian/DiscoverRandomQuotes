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
