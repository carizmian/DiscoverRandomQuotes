//
//  AppGroup.swift
//  QuoteGarden
//
//  Created by Master Family on 18/10/2020.
//

import Foundation

public enum AppGroup: String {
    case facts = "group.com.example.QuoteGarden"
    
    public var containerURL: URL {
        switch self {
        case .facts:
            return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
}
