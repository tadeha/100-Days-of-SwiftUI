//
//  AddBookView.swift
//  Bookworm
//
//  Created by Tadeh Alexani on 5/14/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @State private var title = ""
  @State private var author = ""
  @State private var genre = ""
  @State private var review = ""
  @State private var rating = 3
  
  @State private var showingAlert = false
  
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)
          
          Picker("Genre", selection: $genre) {
            ForEach(genres, id:\.self) {
              Text($0)
            }
          }
        }
        
        Section {
          RatingView(rating: $rating)
          
          TextField("Write a review", text: $review)
        }
        
        Section {
          Button("Save") {
            if self.genre.isEmpty {
              self.showingAlert = true
            } else {
              let book = Book(context: self.moc)
              
              book.title = self.title
              book.author = self.author
              book.genre = self.genre
              book.rating = Int16(self.rating)
              book.review = self.review
              book.date = Date()
              
              if self.moc.hasChanges {
                try? self.moc.save()
              }
              
              self.presentationMode.wrappedValue.dismiss()
            }
          }
        }
      }
      .navigationBarTitle("Add Book", displayMode: .inline)
      .alert(isPresented: $showingAlert) {
        Alert(title: Text("Error Saving"), message: Text("Please choose a Genre for the book"), dismissButton: .default(Text("OK")))
      }
    }
  }
}

struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}
