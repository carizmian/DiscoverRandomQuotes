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
    @State private var showReminders = false
    
    @EnvironmentObject var activeSheet: ActiveSheet

    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section(header: Text("Reminders")) {
                    Button(action: {showReminders.toggle()}) {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                            Text("Reminders")
                        }
                    }
                }
                
                Section(header: Text("Legal")) {
                    ForEach(items.legal, id: \.self) { item in
                        Link(destination: URL(string: "\(item.url)")!) {
                            SettingsRowView(item: item)
                        }
                        
                    }
                }
                Section(header: Text("Feedback")) {
                    ForEach(items.feedback, id: \.self) { item in
                        Link(destination: URL(string: "\(item.url)")!) {
                            SettingsRowView(item: item)
                        }
                        
                    }
                }
                
                Section(header: Text("Miscellaneous")) {
                    ForEach(items.miscellaneous, id: \.self) { item in
                        Link(destination: URL(string: "\(item.url)")!) {
                            SettingsRowView(item: item)
                        }
                    }
                }
                
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
        }.sheet(isPresented: $showReminders, content: {ReminderOnboardingView()})
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
