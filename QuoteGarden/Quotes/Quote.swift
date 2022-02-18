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
    case text = "quoteText"
    case author = "quoteAuthor"
    case genre = "quoteGenre"
  }
  static let help = Quote(
    id: "1",
    text: "Tap here to generate a random quote",
    author: "Nikola Franičević",
    genre: "help"
  )
  static let screenshot = Quote(
    id: "2",
    text: "Success usually comes to those who are too busy looking for it",
    author: "Henry David Thoreau",
    genre: "motivation"
  )
}
