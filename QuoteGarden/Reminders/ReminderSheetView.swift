//
//  ReminderSheetView.swift
//  QuoteGarden
//
//  Created by Master Family on 27/10/2020.
//

import SwiftUI

struct ReminderSheetView: View {

    @State private var date = Date()

    var dateString: String {

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let string = formatter.string(from: date)
        return string
    }

    var body: some View {
        Form {

            Section(header: Text("remind me at"), footer: Text("EVERY DAY")) {

                    DatePicker("Select time", selection: $date, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                    }

            Button(action: {

                setNotification()

            }) {
                HStack {
                    Image(systemName: "deskclock")
                    Text("Set reminder")
                }
            }.buttonStyle(ColoredButtonStyle())
        }.accentColor(.purple)
    }
    func setNotification() {
        let manager = LocalNotificationManager()
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        manager.addNotification(title: "Discover new quotes now!")
        manager.schedule(components: components)
        print(manager.notifications)
    }
}

struct ReminderSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderSheetView()
    }
}
