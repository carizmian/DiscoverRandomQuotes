//
//  ReminderDetailView.swift
//  QuoteGarden
//
//  Created by Master Family on 17/03/2021.
//

import SwiftUI

struct ReminderDetailView: View {
    @State private var reminderFrequency = 8.0
    @State private var reminderTime = Date()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How many")) {
                    Stepper(value: $reminderFrequency, in: 1...12, step: 1.0) {
                        Text("\(reminderFrequency, specifier: "%g")X")
                    }
                }
                Section(header: Text("Schedule")) {
                    DatePicker("Start at", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    DatePicker("End at", selection: $reminderTime, displayedComponents: .hourAndMinute)

                }
            }.navigationTitle("Edit Reminder")
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView()
    }
}
