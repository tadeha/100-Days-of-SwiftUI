//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Tadeh Alexani on 5/16/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var movies: FetchedResults<Movie>
  
  var body: some View {
    VStack(alignment: .center) {
      List {
        ForEach(movies, id: \.self) { movie in
          HStack {
            VStack(alignment: .leading) {
              Text(movie.wrappedTitle)
                .font(.headline)
              Text(movie.wrappedDirector)
                .font(.subheadline)
            }
            Spacer()
            Text("\(movie.year)")
              .foregroundColor(.secondary)
          }
        }
      }
      
      Button("Add") {
        let movie = Movie(context: self.moc)
        movie.title = "Titanic"
        movie.director = "James Cameron"
        movie.year = Int16(1998)
      }
      .padding()
      
      Button("Save") {
        do {
          if self.moc.hasChanges {
            try self.moc.save()
          }
        } catch {
          print(error.localizedDescription)
        }
      }
      .padding()
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
