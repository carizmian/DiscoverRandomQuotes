//
//  ShareSheetView.swift
//  QuoteGarden
//
//  Created by Master Family on 13/10/2020.
//

import SwiftUI
import UIKit


struct ShareSheetView: UIViewControllerRepresentable {

    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ Error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing
    }
}

struct ShareSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheetView(activityItems: ["a quote" as NSString])
    }
}
