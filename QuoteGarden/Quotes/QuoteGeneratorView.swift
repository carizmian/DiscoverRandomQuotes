//
//  QuoteGeneratorView.swift
//  QuoteGarden
//
//  Created by Master Family on 25/10/2020.
//

import SwiftUI
import Foundation

struct QuoteGeneratorView: View {
    
    @State private var quote: Quote = Quote(id: "", quoteText: "Tap the random button", quoteAuthor: "Nikola Franičević", quoteGenre: "knowledge")
    
    var copyToClipboard: (_ quoteGenre: String, _ quoteText: String, _ quoteAuthor: String) -> Void
    var addToFavorites: (_ id: String, _ text: String, _ author: String, _ genre: String) -> Void
    
    @Binding var changedQuote: Bool
    @Binding var addedToFavorites: Bool
    @Binding var showingShareSheetView: Bool

    @Binding var rect1: CGRect
    @Binding var uiimage: UIImage?
    
    var body: some View {
        
        VStack {
            
            Color.clear.overlay(
                QuoteView(genre: "\(quote.quoteGenre)", text: "\(quote.quoteText)", author: "\(quote.quoteAuthor)")
                    .layoutPriority(2)
                    .edgesIgnoringSafeArea(.all)
                    .rotation3DEffect(changedQuote ? Angle(degrees: 360) : Angle(degrees: 0), axis: (x: 0, y: 1, z: 0))
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .onEnded({ value in
                                    
                                    if value.translation.width < 0 {
                                        withAnimation(Animation.easeOut(duration: 1)) {
                                            changedQuote.toggle()
                                        }
                                        quoteGardenApi().getRandomQuote { quote in
                                            withAnimation(.default) {
                                                self.quote = quote
                                                addedToFavorites = false
                                            }
                                        }
                                    }
                                }))
            )
            .background(RectGetter(rect: $rect1))
            .onAppear{
                self.uiimage = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: rect1)
            }
            
            HStack {
                Button(action: { showingShareSheetView = true }) {
                    Image(systemName: "square.and.arrow.up")
                        .accessibilityLabel(Text("Share quote"))
                    
                }.customCircleButtonStyle()

                
                Button(action: { copyToClipboard(_: quote.quoteGenre, quote.quoteText, quote.quoteAuthor )}) {
                    Image(systemName: "doc.on.doc")
                        .accessibilityLabel(Text("Copy quote"))

                    
                    
                }.customCircleButtonStyle()

                
                
                Button(action: { addToFavorites(_: self.quote.id, self.quote.quoteText, self.quote.quoteAuthor, self.quote.quoteGenre) }) {
                    Image(systemName: addedToFavorites ? "heart.fill" : "heart")
                        .accessibilityLabel(Text("Add quote to your favorites"))
                    
                }.customCircleButtonStyle()

                
            }
            
            
        }
    }
}

//struct QuoteGeneratorView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteGeneratorView()
//    }
//}
