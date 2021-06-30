//
//  SettingsView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/03/2021.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    static let tag: String? = "Settings"
    var items = Items()
    var body: some View {
                    
            VStack {
                
                List {

                   
                    Section(header: Text("Reminders")) {
                        NavigationLink(destination: ReminderView()) {
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
//                .navigationBarTitle("Settings")
//                .navigationBarTitleDisplayMode(.inline)
            }
        //}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
