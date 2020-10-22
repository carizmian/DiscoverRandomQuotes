//
//  SwipeObserver.swift
//  QuoteGarden
//
//  Created by Master Family on 22/10/2020.
//

import Foundation
import SwiftUI

struct Cards : Identifiable {
    
var id : Int
var drag : CGFloat
var degree : Double
var color : Color
    
}

class SwipeObserver : ObservableObject{
    
    @Published var cards = [Cards]()
    
    init() {
        
        self.cards.append(Cards(id: 0, drag: 0, degree: 0, color: Color.purple))
        //Skipping for brevity
    }
    
    func update(id : Cards,value : CGFloat,degree : Double){
        
        for i in 0..<self.cards.count{
            
            if self.cards[i].id == id.id{
                
                self.cards[i].drag = value
                self.cards[i].degree = degree
            }
        }
    }
}
