//
//  ContentView.swift
//  Bookworm
//
//  Created by Tadeh Alexani on 5/13/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Book.entity(), sortDescriptors: [
    NSSortDescriptor(keyPath: \Book.title, ascending: true)
    //    NSSortDescriptor(keyPath: \Book.author, ascending: true)
  ]) var books: FetchedResults<Book>
  
  @State private var showingAddBook = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(self.books, id:\.self) { book in
          NavigationLink(destination: DetailView(book: book)) {
            
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            
            VStack(alignment: .leading) {
              Text(book.title ?? "Unknown Title")
                .font(.headline)
                .foregroundColor(book.rating == 1 ? Color.red : Color.primary )
              Text(book.author ?? "Unknown Author")
                .foregroundColor(.secondary)
            }
          }
        }
        .onDelete(perform: deleteBooks)
      }
        
      .navigationBarTitle("Bookworm")
      .navigationBarItems(leading:
        EditButton(), trailing: Button(action: {
          self.showingAddBook.toggle()
        }, label: {
          Image(systemName: "plus")
        }))
        .sheet(isPresented: $showingAddBook) {
          AddBookView().environment(\.managedObjectContext, self.moc)
      }
    }
  }
  
  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      let book = books[offset]
      moc.delete(book)
    }
    
    try? moc.save()
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
