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
  @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
  
  @State private var showingAddBook = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(self.books, id:\.self) { book in
          NavigationLink(destination: Text(book.title ?? "Unknown Author")) {
            
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            
            VStack(alignment: .leading) {
              Text(book.title ?? "Unknown Title")
                .font(.headline)
              Text(book.author ?? "Unknown Author")
                .foregroundColor(.secondary)
            }
          }
        }
      }
      
      .navigationBarTitle("Bookworm")
        .navigationBarItems(trailing: Button(action: {
          self.showingAddBook.toggle()
        }, label: {
          Image(systemName: "plus")
        }))
        .sheet(isPresented: $showingAddBook) {
          AddBookView().environment(\.managedObjectContext, self.moc)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
