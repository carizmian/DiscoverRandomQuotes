//
//  SearchBar.swift
//  QuoteGarden
//
//  Created by Master Family on 21/10/2020.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                TextField("Search by author", text: $text)
                
            }.padding(8)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(25)
            .onTapGesture {
                isEditing = true
            }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing)
                .transition(.move(edge: .trailing))
                .animation(.default)
                
            }
        }.padding([.leading, .trailing])
        .animation(.default)
        .accessibility(label: Text("Searchbar"))
        .accessibility(hint: Text("Search favorite quotes by quote author"))
        .accessibility(addTraits: .isSearchField)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
