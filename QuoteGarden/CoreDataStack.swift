//
//  CoreDataStack.swift
//  QuoteGarden
//
//  Created by Master Family on 05/11/2020.
//

import CoreData

public extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    var managedObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    var workingContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.managedObjectContext
        return context
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "QuoteGarden")
        let storeURL = URL.storeURL(for: "group.com.example.QuoteGarden", databaseName: "QuoteGarden")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createSampleData() throws {
        // the pool of data, holds active objects
        let context = persistentContainer.viewContext
        
        // context - where do they live
        let errorHandlingQuote = QuoteCD(context: context)
        errorHandlingQuote.id = "1"
        errorHandlingQuote.quoteGenre = "error"
        errorHandlingQuote.quoteText = "No favorite quotes! Please add a quote to your favorites to display it here!"
        errorHandlingQuote.quoteAuthor = "Nikola Franičević"
        
        try? context.save()
        
        
        try context.save()
    }
    
//    func deleteAll() {
//        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = QuoteCD.fetchRequest()
//        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
//        _ = try? persistentContainer.viewContext.execute(batchDeleteRequest1)
//    }
    
}
