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
                                        NavigationLink(destination:   QuoteListView(removeQuote: removeQuote, favoriteQuotes: favoriteQuotes, synthesizer: synthesizer)
                                                        //                .tag(QuoteListView.tag)
                                                        //                .tabItem {
                                                        //                    Label("Saved", systemImage: "bookmark.fill")
                                                        //                }
                                                        .accessibilityLabel(Text("Saved quotes"))
                                                        .accessibility(hint: Text("Find your saved quotes here"))) {
//                                            Image(systemName: "text.book.closed.fill")
//                                                .font(.title)

                                        }
                                    
                                    , trailing:
                                        NavigationLink(destination: SettingsView()
                                                        .tag(SettingsView.tag)
                                                        //                .tabItem {
                                                        //                    Label("Settings", systemImage: "gearshape.2.fill")
                                                        //                }
                                                        .accessibilityLabel(Text("Settings"))
                                                        .accessibility(hint: Text("Find settings and social links here"))) {

                                            Image(systemName: "line.horizontal.3")
                                                .font(.title)
                                                
                                                
                                        }
                                    
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
