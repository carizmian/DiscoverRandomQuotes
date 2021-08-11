import SwiftUI
import UIKit

struct SettingsRowView: View {
    let item: Item
    var body: some View {
        HStack {
            ZStack {
//                RoundedRectangle(cornerRadius: 8, style: .continuous)
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(Color(UIColor.colorWith(name: item.color.rawValue)!))
                Image(systemName: item.image)
//                    .foregroundColor(.white)
            }
            
            Text(item.title)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(item: Item(image: "phone.fill", color: .systemGreen, title: "Phone", section: .legal, url: ""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        SettingsRowView(item: Item(image: "gear", color: .systemGray, title: "General", section: .legal, url: ""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}
