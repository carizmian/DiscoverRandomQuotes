//
//  QuoteGarden_AppClipApp.swift
//  QuoteGarden-AppClip
//
//  Created by Master Family on 06/02/2021.
//

import SwiftUI

@main
struct QuoteGarden_AppClipApp: App {
    @State private var showingShareSheetView = false
    var body: some Scene {
        WindowGroup {
            ContentView(showingShareSheetView: $showingShareSheetView)
        }
    }
}
