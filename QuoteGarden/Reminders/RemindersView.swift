//
//  RemindersView.swift
//  QuoteGarden
//
//  Created by Master Family on 15/10/2020.
//

import SwiftUI

struct RemindersView: View {

    static let tag: String? = "Reminders"

    @State private var addingReminder = false

    var body: some View {

        NavigationView {
            VStack {

                Button("Add new reminder ") {
                    addingReminder.toggle()
                }.buttonStyle(ColoredButtonStyle())

            }.navigationBarTitle("Reminders")
        }.sheet(isPresented: $addingReminder) {
            ReminderSheetView()
        }

    }

}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
