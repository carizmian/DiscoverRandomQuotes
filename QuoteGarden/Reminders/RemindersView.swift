//
//  RemindersView.swift
//  QuoteGarden
//
//  Created by Master Family on 15/10/2020.
//

import SwiftUI

struct RemindersView: View {
    
    @State private var date = Date()
    
    
    var body: some View {
        VStack {
            Text("When do you want to learn new quotes?")
                .font(.largeTitle)
            DatePicker("Enter time", selection: $date)
                .datePickerStyle(WheelDatePickerStyle())
                .frame(maxHeight: 400)
            
            Button(action: { setNotification() }) {
                Text("Set Reminder")
            }
        }
    }
    
    func setNotification() -> Void {
        let manager = LocalNotificationManager()
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        manager.addNotification(title: "Discover new quotes now!")
        manager.schedule(components: components)
    }
}


struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
