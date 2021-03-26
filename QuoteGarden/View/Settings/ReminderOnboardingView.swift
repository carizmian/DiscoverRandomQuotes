//
//  ReminderOnboardingView.swift
//  QuoteGarden
//
//  Created by Master Family on 18/03/2021.
//

import SwiftUI
extension Int {
    func toDouble() -> Double {
        Double(self)
    }
}

extension Double {
    func toInt() -> Int {
        Int(self)
    }
}

struct ReminderOnboardingView: View {
    @State private var reminderFrequency = 13.0
    @State private var reminderStartTime = Date(timeIntervalSince1970: TimeInterval(7*60*60))
    @State private var reminderEndTime = Date(timeIntervalSince1970: TimeInterval(19*60*60))
    let manager = LocalNotificationManager()
    
    var body: some View {
        VStack {
            Text("Set daily Spontaneous reminders.")
                .font(.title)
                .fontWeight(.bold)
            Form {
                
                HStack {
                    Text("Remind me")
                    Stepper(value: $reminderFrequency, in: 1...16, step: 1.0) {
                        Text("\(reminderFrequency, specifier: "%g") times")
                    }
                    
                }
                DatePicker("Start at", selection: $reminderStartTime, displayedComponents: .hourAndMinute)
                DatePicker("End at", selection: $reminderEndTime, displayedComponents: .hourAndMinute)
                
            }
            Button(action: {setNotification()}, label: {
                Text("Continue")
            })
            Button(action: {UNUserNotificationCenter.current().removeAllPendingNotificationRequests()}, label: {
                Text("Cancel All")
            })
        }
    }
    
    
    func setNotification() {
        
        let firstDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderStartTime)
        let lastDateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderEndTime)
        
        var dateComponentsArray = Array<DateComponents>()
        
        for int in 0...reminderFrequency.toInt()-1 {
            print(int)
            var date = reminderStartTime.advanced(by: TimeInterval((firstDateComponents.hour!)+(int*60*60)))
            
            print("date: \(date)")
            
            var dateComponent = Calendar.current.dateComponents([.hour, .minute], from: date)
            print(dateComponent)
            
            dateComponentsArray.append(dateComponent)
        }
        
        
        for dateComponents in dateComponentsArray {
            manager.addNotification(title: "This is a test reminder", body: "This is the body", dateComponents: dateComponents)
        }
        
        manager.schedule()
        
        
        
    }
}

struct ReminderOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderOnboardingView()
    }
}
