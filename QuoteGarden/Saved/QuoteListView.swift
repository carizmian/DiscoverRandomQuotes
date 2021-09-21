import SwiftUI
import Foundation

struct QuoteListView: View {
  // MARK: - Core Data
  @Environment(\.managedObjectContext) var moc
  var savedQuotes: FetchedResults<SavedQuote>
  @State private var searchText = ""
  @State private var startAnimation = false
  @EnvironmentObject var storage: Storage
  @State private var showBuying = false
  var body: some View {
    ZStack {
      ShakableViewRepresentable()
        .allowsHitTesting(false)
      VStack {
        SearchBar(text: $searchText)
          .padding(.top, 8)
        List {
          ForEach(savedQuotes.filter { searchText.isEmpty ? true : $0.wrappedAuthor.contains(searchText) }, id: \.id) { savedQuote in
            NavigationLink(destination: QuoteDetailView(savedQuote: savedQuote)) {
              HStack {
                QuoteRowView(savedQuote: savedQuote)
              }
            }
          }.onDelete(perform: onDelete)
        }.listStyle(PlainListStyle())
        .navigationBarTitle(Text("Your Saved Quotes"))
        .navigationBarItems(trailing: EditButton())
        .edgesIgnoringSafeArea(.bottom)
        if storage.amount == 3 { Button {
          showBuying.toggle()
        } label: {
          HStack {
            Text("\(savedQuotes.count)/\(3)")
            Image(systemName: "cart.fill")
              .overlay(
                Image(systemName: "cart.fill")
                  .scaleEffect(startAnimation ? 1.1 : 1)
                  .opacity(startAnimation ? 0 : 1))
              .rotationEffect(Angle(degrees: startAnimation ? 360 : 0))
              .animation(Animation.easeOut(duration: 0.6).delay(3).repeatForever(autoreverses: false))
          }.padding(8)
          .background(Color.accentColor)
          .clipShape(RoundedRectangle(cornerRadius: 40))
          .foregroundColor(Color("TextColor"))
          .padding(8)
        }
        }
      }.onReceive(messagePublisher) { _ in
        print(moc.undoManager?.canUndo ?? "error")
        moc.undo()
        print("Shaking")
      }
      .sheet(isPresented: $showBuying) {
        BuyStorageSheetView(showBuying: $showBuying)
      }
    }.onAppear {
      startAnimation.toggle()
    }
  }
  private func onDelete(with indexSet: IndexSet) {
    indexSet.forEach { index in
      let quote = savedQuotes[index]
      moc.delete(quote)
    }
    try? moc.saveContext()
  }
}
