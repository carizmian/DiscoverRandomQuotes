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
                    .padding(.bottom)
                    .allowsTightening(true)
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .accessibilityLabel(Text("quote genre is hashtag \(quoteGenre)"))

                Text("""
                    "\(quoteText)"
                    """)
                    .italic()
                    .font(Font.system(.title, design: .monospaced).weight(.black))
                    .padding(.horizontal)
                    .allowsTightening(true)
                    .layoutPriority(2)
                    .minimumScaleFactor(0.3)
                    .accessibilityLabel(Text("quote text is \(quoteText)"))
                    
                
                    
                
                Text("~ \(quoteAuthor)")
                    .padding(.top)
                    .allowsTightening(true)
                    .font(Font.system(.callout, design: .monospaced).weight(.bold))
                    .accessibilityLabel(Text("quote author is \(quoteAuthor)"))
                    
                
                
            }.padding(.vertical)
            .multilineTextAlignment(.center)
        
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            
            QuoteView(quoteGenre: "nature", quoteText: "Human beings are accustomed to think of intellect as the power of having and controlling ideas and of abilty to learn as synonymous with ability to have ideas. But learning by having ideas is really one of the rare and isolated events in nature.", quoteAuthor: "Edward Thorndike")
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                            .previewDisplayName("iPhone 11 Pro Max")
                
        }
    }
}
