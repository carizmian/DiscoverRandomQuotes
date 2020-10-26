//
//  DataController.swift
//  QuoteGarden
//
//  Created by Master Family on 26/10/2020.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "QuoteGarden")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal erorr creating preview: \(error.localizedDescription)")
        }
        return dataController
    }()
    
    
    func createSampleData() throws {
        // the pool of data, holds active objects
        let viewContext = container.viewContext
        
        // context - where do they live
        let quote = QuoteCD(context: viewContext)
        quote.id = "123"
        quote.quoteGenre = "science"
        quote.quoteText = "Knowledge is power"
        quote.quoteAuthor = "Nikola Franičević"
        
        try viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = QuoteCD.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
}

