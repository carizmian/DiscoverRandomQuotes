//
//  ToggleMode.swift
//  QuoteGarden
//
//  Created by Master Family on 04/03/2021.
//

import Foundation

//TODO: SAVES THE STATE AFTER USER EXITS APP
struct ToggleModel {
    var isDark: Bool = false {
        didSet {
            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
}
