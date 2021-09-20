import CoreData

class CoreDataStack {
  private let containerName: String
  var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        print(error.localizedDescription)
      }
      print(storeDescription)
    }
    return container
  }()
  init(containerName: String) {
    self.containerName = containerName
    _ = persistentContainer
    print("initialising CoreDataStack with container name: \(containerName)")
  }
}

extension NSManagedObjectContext {
  func saveContext() throws {
    guard hasChanges else { return }
    try save()
  }
}
