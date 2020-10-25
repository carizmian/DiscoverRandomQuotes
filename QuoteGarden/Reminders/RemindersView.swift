//
//  RemindersView.swift
//  QuoteGarden
//
//  Created by Master Family on 15/10/2020.
//

import SwiftUI

struct RemindersView: View {

    @State private var date = Date()
    @State private var reminderIsSet = false

    #warning("display array of notifications and enable reminder deletion!")

    var dateString: String {

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let string = formatter.string(from: date)
        return string
    }

    var body: some View {

            VStack {

                Text("When do you want to discover new quotes?")
                    .font(.largeTitle)
                DatePicker("Select time", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()

                Button(action: {

                    setNotification()
                    reminderIsSet = true

                }) {
                    Image(systemName: "deskclock")
                    Text("Set reminder")
                }.customCapsuleButtonStyle()
                .overlay(
                    Capsule()
                        .stroke(Color.purple, lineWidth: 4)
                        .scaleEffect(reminderIsSet ? 2 : 1)
                        .opacity(reminderIsSet ? 0 : 1))
                .animation(Animation.easeOut(duration: 0.6))

            }.alert(isPresented: $reminderIsSet, content: {
                Alert(title: Text("Success!"), message: Text("You will get reminded to discover quotes at \(dateString) every day!"))
        })
            .padding()

    }

    func setNotification() {
        let manager = LocalNotificationManager()
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        manager.addNotification(title: "Discover new quotes now!")
        manager.schedule(components: components)
        print(manager.notifications)
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
