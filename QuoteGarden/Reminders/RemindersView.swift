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
    #warning("pojavljuju se svi reminderi koji su setani bili, to moramo popravit pod hitno!")
    var dateString: String {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let string = formatter.string(from: date)
        return string
    }
    
    var body: some View {
        
        NavigationView {
            VStack {

                NavigationLink(destination: Text("reminders")) {
                    Text("List of reminders")
                }

                Color.clear.overlay(
                    VStack {
                        Text("When do you want to discover new quotes?")
                            .font(.title)
                        
                        DatePicker("Select time", selection: $date, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }.padding()
                )
                Button(action: {
                    
                    setNotification()
                    reminderIsSet = true
                    
                }) {
                    HStack {
                        Image(systemName: "deskclock")
                        Text("Set reminder")
                    }
                }.buttonStyle(ColoredButtonStyle())
                
            }.navigationBarTitle("Reminders")
            .navigationBarItems(trailing: EditButton())
        }.alert(isPresented: $reminderIsSet, content: {
            Alert(title: Text("Success!"), message: Text("You will get reminded to discover quotes at \(dateString) every day!"))
        })
        
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
