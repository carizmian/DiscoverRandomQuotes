//
//  ContentView.swift
//  QuoteGarden
//
//  Created by Master Family on 03/10/2020.
//

import SwiftUI
import Foundation
import AVFoundation

struct ContentView: View {
    
    @AppStorage("selectedView") var selectedView: String?
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: QuoteCD.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \QuoteCD.quoteAuthor, ascending: true)]) var favoriteQuotes: FetchedResults<QuoteCD>
    @State private var savedToDevice = false
    @State private var showingShareSheetView = false
    
    let synthesizer =  AVSpeechSynthesizer()
    
    @State private var showOnboarding = false
    @AppStorage("OnboardBeenViewed") var hasOnboarded = false
    
    @State private var showSettings = false
    @State private var showSavedQuotes = false
    
    var body: some View {
        
        // TabView(selection: $selectedView) {
        
        NavigationView {
            
            QuoteGeneratorView(savedToDevice: $savedToDevice, showingShareSheetView: $showingShareSheetView, synthesizer: synthesizer)
                .tag(QuoteGeneratorView.tag)
                //                .tabItem {
                //                    Label("Random", systemImage: "text.quote")
                //                }
                .accessibilityLabel(Text("Random quotes"))
                .accessibility(hint: Text("Find new quotes here"))
                .navigationBarItems(leading:
                                        
                                        Button(action: {showSavedQuotes.toggle()}, label: {
                                            Image(systemName: "bookmark.fill")
                                                .font(.title)
                                        }).accessibilityLabel(Text("Saved quotes"))
                                        .accessibility(hint: Text("Find your saved quotes here"))
                                    
                                    , trailing:
                                        
                                        Button(action: {showSettings.toggle()}, label: {
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
            if !hasOnboarded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showOnboarding.toggle()
                        hasOnboarded = true
                    }
                }
            }
        }
        .popover(isPresented: $showOnboarding) {
            ReminderOnboardingView()
        }
        #warning("Settings not showing")
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showSavedQuotes) {
            QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes, synthesizer: synthesizer)
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
