//
//  DetailView.swift
//  Bookworm
//
//  Created by Tadeh Alexani on 5/15/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  @State private var showingDeleteAlert = false
  
  let book: Book
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 20) {
        ZStack(alignment: .bottomTrailing) {
          Image(self.book.genre ?? "Fantasy")
            .frame(maxWidth: geo.size.width)
          Text(self.book.genre?.uppercased() ?? "Fantasy")
            .font(.caption)
            .fontWeight(.black)
            .foregroundColor(.white)
            .padding(8)
            .background(Color.black.opacity(0.75))
            .clipShape(Capsule())
            .offset(x: -5, y: -5)
        }
        Text(self.book.author ?? "Unknown author")
          .font(.title)
          .foregroundColor(.secondary)
        
        Text(self.book.review ?? "No review")
          .padding()
        
        RatingView(rating: .constant(Int(self.book.rating)))
          .font(.largeTitle)
        
        Text("Created at: \(self.dateFormatter(self.book.date ?? Date()))")
          .font(.callout)
          .foregroundColor(.secondary)
          .padding()
        
        Spacer()
      }
    }
    .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    .navigationBarItems(trailing: Button(action: {
      self.showingDeleteAlert = true
    }, label: {
      Image(systemName: "trash")
    }))
      .alert(isPresented: $showingDeleteAlert) {
        Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete"), action: deleteBook), secondaryButton: .cancel())
    }
  }
  
  func deleteBook() {
    moc.delete(book)
    
    // uncomment this line if you want to make the deletion permanent
    // try? self.moc.save()
    
    presentationMode.wrappedValue.dismiss()
  }
  
  func dateFormatter(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
  
}

struct DetailView_Previews: PreviewProvider {
  
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
  static var previews: some View {
    let book = Book(context: moc)
    book.title = "Book Title"
    book.author = "Book Author"
    book.genre = "Fantasy"
    book.review = "Some Review"
    book.rating = Int16(4)
    
    return DetailView(book: book)
  }
}
