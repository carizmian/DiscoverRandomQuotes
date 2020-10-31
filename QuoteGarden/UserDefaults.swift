//
//  UserDefaults.swift
//  QuoteGarden
//
//  Created by Master Family on 31/10/2020.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        guard let defaults = UserDefaults(suiteName: "group.com.example.QuoteGarden") else {
            print("Can't access shared")
            return UserDefaults.standard
        }
        
        return defaults
    }
}
