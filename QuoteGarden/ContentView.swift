//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation
import AVFoundation

final class ActiveSheet: ObservableObject {
    enum Kind {
        case onboard
        case quotes
        case settings
        case none
    }
    @Published var kind: Kind = .none {
        didSet { showSheet = kind != .none }
    }
    @Published var showSheet: Bool = false
}

struct ContentView: View {
    
    @AppStorage("selectedView") var selectedView: String?
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var savedToDevice = false
    @State private var showingShareSheetView = false
    
    let synthesizer =  AVSpeechSynthesizer()
    
    @AppStorage("OnboardBeenViewed") var hasOnboarded = false
    
    @ObservedObject var activeSheet: ActiveSheet = ActiveSheet()
    
    var body: some View {
        
        // TabView(selection: $selectedView) {
        NavigationView {
            #warning("fix ipad view it's in half!")
            QuoteGeneratorView(savedToDevice: $savedToDevice, showingShareSheetView: $showingShareSheetView, synthesizer: synthesizer)
                .tag(QuoteGeneratorView.tag)
                //                .tabItem {
                //                    Label("Random", systemImage: "text.quote")
                //                }
                .accessibilityLabel(Text("Random quotes"))
                .accessibility(hint: Text("Find new quotes here"))
                .navigationBarItems(leading:
                                        
                                        Button(action: {
                                            activeSheet.kind = .quotes
                                        }, label: {
                                            Image(systemName: "bookmark.fill")
                                                .font(.title)
                                        }).accessibilityLabel(Text("Saved quotes"))
                                        .accessibility(hint: Text("Find your saved quotes here")), trailing:
                                            
                                            Button(action: {
                                                activeSheet.kind = .settings
                                            }, label: {
                                                Image(systemName: "gearshape.fill")
                                                    .font(.title)
                                            }).accessibilityLabel(Text("Settings"))
                                            .accessibility(hint: Text("Find settings and social links here"))
                )
            
            //            ReminderOnboardingView()
            //                .tabItem {
            //                    Label("test", systemImage: "gearshape.2.fill")
            //                }
            
            // }
        }.onAppear {
            moc.undoManager = UndoManager()
            AppReviewRequest.requestReviewIfNeeded()
            
            hasOnboarded = false // here for testing
            // When the user dismisses the onboarding view by swiping down, we will also consider onboarding as complete
            if !hasOnboarded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        activeSheet.kind = .onboard
                        hasOnboarded = true
                    }
                }
            }
        }
        .sheet(isPresented: self.$activeSheet.showSheet, content: { self.sheet })
    }
    private var sheet: some View {
        #warning("prvi stisak ne radi!, pa onda proradi")
        switch activeSheet.kind {
        case .none:
            return AnyView(ContentView())
        case .onboard:
            return AnyView(ReminderOnboardingView())
        case .quotes:
            return AnyView(QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes, synthesizer: synthesizer))
        case .settings:
            return AnyView(SettingsView())
        }
    }
    
    func removeQuote(at offsets: IndexSet) {
        for index in offsets {
            let favoriteQuote = favoriteQuotes[index]
            
            moc.delete(favoriteQuote)
            
        }
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
