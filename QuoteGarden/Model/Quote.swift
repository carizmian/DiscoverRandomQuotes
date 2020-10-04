//
//  Quote.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import Foundation

// MARK: - Response
struct Response: Decodable {
    let statusCode: Int
    let quotes: [Quote]
}

// MARK: - Quote
struct Quote: Decodable {
    let id, quoteText, quoteAuthor: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quoteText, quoteAuthor
    }
}

class quoteGardenApi {
    
    @Published var page = 1
    @Published var chunkSize = 1000
    
    
    func getAllQuotes(completion: @escaping ([Quote]) -> Void) {
        
        var semaphore = DispatchSemaphore (value: 0)
        
        let url = URL(string: "https://quote-garden.herokuapp.com/api/v2/quotes?page=\(page)&limit=\(chunkSize)")
        
        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                print(String(describing: error))
                return
            }
            DispatchQueue.main.async {
                completion(response.quotes)
            }
            
            
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    func searchAuthor(author: String, completion: @escaping ([Quote]) -> Void) {
        
        var semaphore = DispatchSemaphore (value: 0)
        
        let url = URL(string: "https://quote-garden.herokuapp.com/api/v2/authors/\(author)?page=1&limit=10")
        
        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                print(String(describing: error))
                return
            }
            
            
            
            DispatchQueue.main.async {
                completion(response.quotes)
            }
            
            
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
}
