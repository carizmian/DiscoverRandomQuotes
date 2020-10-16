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
public class QuoteCD: NSManagedObject {
        
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCD> {
        return NSFetchRequest<QuoteCD>(entityName: "QuoteCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var quoteAuthor: String?
    @NSManaged public var quoteText: String?
    @NSManaged public var quoteGenre: String?
    
    
    var wrappedQuoteAuthor: String {
        return quoteAuthor ?? "Unknown Author"
    }
    
    var wrappedQuoteText: String {
        return quoteText ?? "Unknown Quote Text"
    }
    
    var wrappedQuoteGenre: String {
        return quoteGenre ?? "Unknown Quote Genre"
    }
    
    
    let storeURL = AppGroup.facts.containerURL.appendingPathComponent("QuoteGarden.xcdatamodeld")
    
}
