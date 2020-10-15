//
//  QuoteView.swift
//  QuoteGarden
//
//  Created by Master Family on 08/10/2020.
//

import SwiftUI

struct QuoteView: View {
    
    var quoteGenre: String
    var quoteText: String
    var quoteAuthor: String
    
    
    var body: some View {

        
        VStack(alignment: .center) {
            
            Text("# \(quoteGenre)")
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .font(Font.system(.subheadline, design: .serif).weight(.ultraLight))

            
            Text("""
                "\(quoteText)"
                """)
                .italic()
                .font(Font.system(.body, design: .serif).weight(.regular))
                .padding(.horizontal)
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .layoutPriority(2)
                
            
            Text("~ \(quoteAuthor)")
                .multilineTextAlignment(.center)
                .padding(.top)
                .foregroundColor(.gray)
                .font(Font.system(.callout, design: .serif).weight(.light))
            
            
        }.padding(.vertical)
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            
            QuoteView(quoteGenre: "nature", quoteText: "Human beings are accustomed to think of intellect as the power of having and controlling ideas and of abilty to learn as synonymous with ability to have ideas. But learning by having ideas is really one of the rare and isolated events in nature.", quoteAuthor: "Edward Thorndike")
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                            .previewDisplayName("iPhone 11 Pro Max")
                
            QuoteView(quoteGenre: "nature", quoteText: "Human beings are accustomed to think of intellect as the power of having and controlling ideas and of abilty to learn as synonymous with ability to have ideas. But learning by having ideas is really one of the rare and isolated events in nature.", quoteAuthor: "Edward Thorndike")
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                            .previewDisplayName("iPhone SE")
            
            QuoteView(quoteGenre: "nature", quoteText: "Human beings are accustomed to think of intellect as the power of having and controlling ideas and of abilty to learn as synonymous with ability to have ideas. But learning by having ideas is really one of the rare and isolated events in nature.", quoteAuthor: "Edward Thorndike")
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                            .previewDisplayName("iPhone 8")
            
            QuoteView(quoteGenre: "nature", quoteText: "Human beings are accustomed to think of intellect as the power of having and controlling ideas and of abilty to learn as synonymous with ability to have ideas. But learning by having ideas is really one of the rare and isolated events in nature.", quoteAuthor: "Edward Thorndike")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            
        }
    }
}
