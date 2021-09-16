import Foundation

// MARK: - Response
struct Response: Codable {
  let statusCode: Int
  let data: [Quote]
}
// MARK: - Quote
struct Quote: Codable, Hashable {
  var id, text, author, genre: String
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case text, author, genre
  }
  static let example = Quote(id: "", text: "Tap here to generate a random quote", author: "Nikola Franičević", genre: "help")
}
