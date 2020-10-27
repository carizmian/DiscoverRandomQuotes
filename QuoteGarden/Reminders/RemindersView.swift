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
    var manager = LocalNotificationManager()

    #warning("show sheet when setting reminder(googlaj appleov reminder app example)")
    #warning("display array of notifications and enable reminder deletion! pojavljuju se svi reminderi koji su setani bili, to moramo popravit pod hitno!")

    var body: some View {

        NavigationView {
            VStack {

                List(manager.notifications, id: \.id) { notification in
                    Text(notification.title)
                }

                Button("Add new reminder ") {
                    addingReminder.toggle()
                }

            }.navigationBarTitle("Reminders")
            .navigationBarItems(trailing: EditButton())
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
