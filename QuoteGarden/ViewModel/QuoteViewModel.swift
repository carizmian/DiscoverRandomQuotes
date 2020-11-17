//
//  QuoteViewModel.swift
//  QuoteGarden
//
//  Created by Master Family on 17/11/2020.
//

import Foundation

class QuoteViewModel: ObservableObject {
    @Published private var quote = Quote(id: "", quoteText: "", quoteAuthor: "", quoteGenre: "")
    
    var id: String {
        quote.id
    }
    
    var quoteText: String {
        quote.quoteText
    }
    
    var quoteAuthor: String {
        quote.quoteAuthor
    }
    
    var quoteGenre: String {
        quote.quoteGenre
    }
    
    func update(_ id: String, _ text: String, _ author: String, _ genre: String) {
        quote.id = id
        quote.quoteText = text
        quote.quoteAuthor = author
        quote.quoteGenre = genre
    }
}
