//
//  SettingsView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/03/2021.
//

import SwiftUI

struct SettingsView: View {
    static let tag: String? = "Settings"
    
    var items = Items()
    @State var model = ToggleModel()
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(header: Text("Appearance")) {
                    HStack {
                    SettingsRowView(item: Item(image: "moon.fill",
                                               color: .systemPurple,
                                               title: "Dark Appearance",
                                               section: .appearance))
                        Toggle("", isOn: $model.isDark)
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        
                        
                    }
                
                }

                Section(header: Text("Legal")) {
                    ForEach(items.legal, id: \.self) { item in
                        NavigationLink(
                            destination: Text(item.title),
                            label: { SettingsRowView(item: item) }
                        )
                    }
                }
                Section(header: Text("Feedback")) {
                    ForEach(items.feedback, id: \.self) { item in
                        NavigationLink(
                            destination: Text(item.title),
                            label: { SettingsRowView(item: item) }
                        )
                    }
                }
                
                Section(header: Text("Miscellaneous")) {
                    ForEach(items.miscellaneous, id: \.self) { item in
                        NavigationLink(
                            destination: Text(item.title),
                            label: { SettingsRowView(item: item) }
                        )
                    }
                }

            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
