//
//  SettingsItems.swift
//  QuoteGarden
//
//  Created by Master Family on 04/03/2021.
//

import Foundation

struct Items {
    private let data: [Item] = [
        
        Item(image: "moon.fill",
             color: .systemPurple,
             title: "Dark Appearance",
             section: .appearance),
        
        Item(image: "star.fill",
             color: .systemYellow,
             title: "Rate The App",
             section: .feedback),
        Item(image: "megaphone.fill",
             color: .systemOrange,
             title: "Provide Feedback",
             section: .feedback),
        Item(image: "ladybug.fill",
             color: .systemRed,
             title: "Report A Bug",
             section: .feedback),
        
        Item(image: "square.and.arrow.up.fill",
             color: .systemGray,
             title: "Share With Friends",
             section: .miscellaneous),
        Item(image: "chevron.left.slash.chevron.right",
             color: .systemGray,
             title: "Source Code",
             section: .miscellaneous),
        Item(image: "globe",
             color: .systemGray,
             title: "Website",
             section: .miscellaneous),
        
        Item(image: "lock.shield.fill",
             color: .systemGreen,
             title: "Privacy",
             section: .legal)
        
    ]
    
    let appearance: [Item]
    let miscellaneous: [Item]
    let legal: [Item]
    let feedback: [Item]
    
    init() {
        appearance = data.filter { $0.section == .appearance }
        miscellaneous = data.filter { $0.section == .miscellaneous }
        legal = data.filter { $0.section == .legal }
        feedback = data.filter { $0.section == .feedback }

    }
}

enum ListSection: CaseIterable {
    case appearance
    case miscellaneous
    case legal
    case feedback
}

struct Item: Identifiable, Hashable {
    
    // MARK: - Types
    enum Color: String, CaseIterable {
        case systemOrange
        case systemBlue
        case systemGreen
        case systemRed
        case systemPurple
        case systemGray
        case cyan
        case systemYellow
        case black
    }
    
    // MARK: - Properties
    var id = UUID()
    let image: String
    let color: Color
    let title: String
    let section: ListSection
    
}

