//
//  PrimaryQuote.swift
//  QuoteGarden
//
//  Created by Master Family on 17/11/2020.
//

import SwiftUI
import WidgetKit

@available(iOS 14, *)
struct PrimaryQuote {
    @AppStorage("primaryQuote", store: UserDefaults(suiteName: "group.com.example.QuoteGarden")) var primaryQuoteData: Data = Data()
    let primaryQuote: Quote
    
    func storeQuote() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(primaryQuote) else {
            print("Could not encode data")
            return
        }
        primaryQuoteData = data
        WidgetCenter.shared.reloadAllTimelines()
        print(String(decoding: primaryQuoteData, as: UTF8.self))
    }
}
