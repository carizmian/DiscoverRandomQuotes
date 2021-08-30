import SwiftUI

struct ReminderView: View {
    @State private var sendReminders = true
    @State private var reminderFrequency = 3.0
    @ObservedObject var manager = NotificationManager.shared
    var body: some View {
        VStack {
            
            Toggle("Send Reminders", isOn: $sendReminders)
                .onDisappear {
                    switch sendReminders {
                    case true: do {
                        manager.addNotifications(reminderFrequency: reminderFrequency)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            manager.setNotifications()
                            print("setting notifications")
                        }
                    }
                    case false: do {
                        manager.center.removeAllPendingNotificationRequests()
                    }
                    }
                }
            Image("Reminder")
                .resizable()
                .scaledToFit()
            VStack {
                Text("Get Quotes reminders.")
                    .multilineTextAlignment(.center)
                
                Stepper(value: $reminderFrequency, in: 3...7) {
                    Text("Every \(reminderFrequency, specifier: "%.f") hours.")
                        .fontWeight(.semibold)
                }.padding()
                
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
