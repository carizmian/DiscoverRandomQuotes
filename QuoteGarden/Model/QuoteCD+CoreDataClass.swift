//
//  QuoteCD+CoreDataClass.swift
//  QuoteGarden
//
//  Created by Master Family on 05/10/2020.
//
//

import Foundation
import CoreData

@objc(QuoteCD)
public class QuoteCD: NSManagedObject, Encodable {
        
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCD> {
        return NSFetchRequest<QuoteCD>(entityName: "QuoteCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var quoteAuthor: String?
    @NSManaged public var quoteText: String?
    @NSManaged public var quoteGenre: String?
    
    private enum CodingKeys: String, CodingKey { case id, quoteAuthor, quoteText, quoteGenre }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(quoteAuthor, forKey: .quoteAuthor)
        try container.encode(quoteText, forKey: .quoteText)
        try container.encode(quoteGenre, forKey: .quoteGenre)
    }
    #warning("JSON goes to the app group")
    
    
    var wrappedQuoteAuthor: String {
        return quoteAuthor ?? "Unknown Author"
    }
    
    var wrappedQuoteText: String {
        return quoteText ?? "Unknown Quote Text"
    }
    
    var wrappedQuoteGenre: String {
        return quoteGenre ?? "Unknown Quote Genre"
    }
    
        
}
