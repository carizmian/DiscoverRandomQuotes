//
//  QuoteGarden_AppClipApp.swift
//  QuoteGarden-AppClip
//
//  Created by Master Family on 06/02/2021.
//

import SwiftUI

@main
struct QuoteGardenAppClipApp: App {
    @State private var showingShareSheetView = false
    var body: some Scene {
        WindowGroup {
            ContentView(showingShareSheetView: $showingShareSheetView).onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                guard let incomingURL = userActivity.webpageURL,
                      let _ = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true)
                else {
                    return
                }
            }
        }
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
        let _ = components.queryItems else {
            return
        }
    }
}
