import SwiftUI

struct ReminderView: View {
    @ObservedObject var manager = NotificationManager.shared
    @StateObject var reminderViewModel = ReminderViewModel()
    var body: some View {
        VStack {
            Toggle("Send Reminders", isOn: $reminderViewModel.sendReminders)
            Image("Reminder")
                .resizable()
                .scaledToFit()
            VStack {
                Text("Get Quotes reminders.")
                    .multilineTextAlignment(.center)
                
                Stepper(value: $reminderViewModel.reminderFrequency, in: 3...7) {
                    Text("Every \(reminderViewModel.reminderFrequency, specifier: "%.f") hours.")
                        .fontWeight(.semibold)
                }.padding()
                
            }
            Spacer()
        }.padding(.horizontal)
        .onDisappear {
            switch reminderViewModel.sendReminders {
            case true: do {
                manager.addNotifications(reminderFrequency: reminderViewModel.reminderFrequency)
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
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
