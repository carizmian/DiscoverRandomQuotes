import SwiftUI

struct ReminderView: View {
  @ObservedObject var manager = NotificationManager.shared
  var body: some View {
    VStack {
      Toggle("Send Reminders", isOn: $manager.sendReminders)
      Image("Reminder")
        .resizable()
        .scaledToFit()
      VStack {
        if manager.sendReminders {
          Text("Set up motivational messages.")
            .multilineTextAlignment(.center)
          Stepper(value: $manager.reminderFrequency, in: 3...7) {
            Text("Every \(manager.reminderFrequency, specifier: "%.f") hours.")
              .fontWeight(.semibold)
          }.padding()
        }
      }.animation(.easeIn)
      Spacer()
    }.padding(.horizontal)
    .onDisappear {
      switch manager.sendReminders {
      case true: do {
        manager.addNotifications()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          manager.setNotifications()
          print("setting notifications")
        }
      }
      case false: do {
        manager.center.removeAllPendingNotificationRequests()
        print("removing all pending notification requests!")
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
