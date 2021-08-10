//
//  SettingsItems.swift
//  QuoteGarden
//
//  Created by Master Family on 04/03/2021.
//

import Foundation

struct Items {
    private let data: [Item] = [
        
        Item(image: "star.fill",
             color: .systemYellow,
             title: "Rate The App",
             section: .feedback,
             url: "https://apps.apple.com/us/app/spontaneous-random-quotes/id1538265374?itsct=apps_box_link&itscg=30200"),
        Item(image: "megaphone.fill",
             color: .systemOrange,
             title: "Provide Feedback",
             section: .feedback,
             url: "https://nikolafranicevic.com/SpontaneousRandomQuotes/feedback"),
        Item(image: "ladybug.fill",
             color: .systemRed,
             title: "Report A Bug",
             section: .feedback,
             url: "https://nikolafranicevic.com/SpontaneousRandomQuotes/feedback"),

        Item(image: "chevron.left.slash.chevron.right",
             color: .systemGray,
             title: "Source Code",
             section: .miscellaneous,
             url: "https://github.com/FranicevicNikola/DiscoverRandomQuotes"),
        Item(image: "globe",
             color: .systemGray,
             title: "Website",
             section: .miscellaneous,
             url: "https://nikolafranicevic.com/SpontaneousRandomQuotes/"),
        
        Item(image: "lock.shield.fill",
             color: .systemGreen,
             title: "Privacy",
             section: .legal,
             url: "https://nikolafranicevic.com/SpontaneousRandomQuotes/privacypolicy/")
        
    ]
    
    let miscellaneous: [Item]
    let legal: [Item]
    let feedback: [Item]
    
    init() {
        miscellaneous = data.filter { $0.section == .miscellaneous }
        legal = data.filter { $0.section == .legal }
        feedback = data.filter { $0.section == .feedback }

    }
}

enum ListSection: CaseIterable {
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
    let url: String
}
