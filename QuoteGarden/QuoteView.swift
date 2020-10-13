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
                .font(Font.system(.title3, design: .serif).weight(.ultraLight))
            
            
            
            Text("""
                "\(quoteText)"
                """)
                .italic()
                .font(Font.system(.title, design: .serif).weight(.regular))
                .padding(.horizontal)
                .allowsTightening(true)
                .multilineTextAlignment(.center)
                .layoutPriority(2)

            
            Text("~ \(quoteAuthor)")
                .multilineTextAlignment(.center)
                .padding(.top)
                .foregroundColor(.gray)
                .font(Font.system(.title2, design: .serif).weight(.light))
            
        }.padding(.vertical, 100.0)
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quoteGenre: "nature", quoteText: "Human beings are accustomed to think of intellect as the power of having and controlling ideas and of abilty to learn as synonymous with ability to have ideas. But learning by having ideas is really one of the rare and isolated events in nature.", quoteAuthor: "Edward Thorndike")
    }
}
