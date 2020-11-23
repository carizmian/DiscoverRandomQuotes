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

            TextField("Search by author", text: $text)
                .padding()
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(50)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.accentColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding()

                        if isEditing {
                            Button(action: {
                                self.text = ""

                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                    }
                )
                .padding(.horizontal)
                .onTapGesture {
                    self.isEditing = true
                }.animation(.default)

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
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
