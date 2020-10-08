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
    
    let heartImage = UIImage(systemName: "heart.fill")!
    //  let redHeartImage = heartImage.withTintColor(.red, renderingMode: .alwaysOriginal)
    
    var body: some View {
        
        
        ZStack {
            Image(systemName: "heart")
                .resizable()
                .frame(width: 350, height: 300)
                .aspectRatio(contentMode: .fill)
                .opacity(0.1)
            
            VStack {
                
                Text("# \(quoteGenre)")
                    .padding()
                    .font(Font.system(.subheadline, design: .serif).weight(.light))
                
                
                
                Text("'\(quoteText)'")
                    .italic()
                    .font(Font.system(.title, design: .serif).weight(.ultraLight))
                    .allowsTightening(true)
                    .multilineTextAlignment(.center)
                    .layoutPriority(2)
                
                
                
                
                
                Text("~ \(quoteAuthor)")
                    .padding()
                    .foregroundColor(.gray)
                    .font(Font.system(.callout, design: .serif).weight(.black))
                
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quoteGenre: "knowledge", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević")
    }
}
