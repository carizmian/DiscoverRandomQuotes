import CoreData
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // MARK: - Core Data
    let coreDataStack = CoreDataStack(containerName: "QuoteGarden")
    coreDataStack.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    // MARK: - IAP
    let store = Store()
    let storage = Storage()
    // MARK: - ViewModel
    let quoteViewModel = QuoteViewModel()
    let contentView = ContentView()
      .environment(\.managedObjectContext, coreDataStack.viewContext)
      .environmentObject(store)
      .environmentObject(storage)
      .environmentObject(quoteViewModel)
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
