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
  // @FetchRequest(entity: Movie.entity(), sortDescriptors: [], predicate: NSPredicate(format: "year == %@", "1998")) var movies: FetchedResults<Movie>
  @State private var yearFilter = 0
  let years = ["2020","1998","1997"]
  
  @State private var showingAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  
  let actors = [""]
  
  var body: some View {
    VStack(alignment: .center) {
      
      Picker(selection: $yearFilter, label: Text("Select a year to filter")) {
        ForEach(0 ..< self.years.count, id: \.self) {
          Text(self.years[$0])
        }
      }.pickerStyle(SegmentedPickerStyle())
        .padding()
      
      
      FilteredList(filterKey: "year", filterValue: Int16(years[yearFilter])!, filterOperator: .equal, sortDescriptors: [NSSortDescriptor(key: "year", ascending: true)]) { (movie: Movie) in
        VStack(spacing: 4) {
          HStack {
            VStack(alignment: .leading) {
              Text(movie.wrappedTitle)
                .font(.headline)
              Text(movie.wrappedDirector)
                .font(.subheadline)
            }
            Spacer()
            Text("\(movie.wrappedYear)")
              .foregroundColor(.secondary)
          }
          HStack() {
            Text("Actors: ")
              .fontWeight(.bold)
            Text(movie.actorArray.map { $0.wrappedName }.joined(separator: ", "))
            Spacer()
          }
          .font(.footnote)
          .foregroundColor(.secondary)
        }
      }
      
      HStack(spacing: 20) {
        
        Button(action: {
          let movie1 = Movie(context: self.moc)
          movie1.title = "Titanic"
          movie1.director = "James Cameron"
          
          let leonardo = Actor(context: self.moc)
          leonardo.name = "Leonardo DiCaprio"
          let kate = Actor(context: self.moc)
          kate.name = "Kate Winslet"
          
          movie1.addToActors(leonardo)
          movie1.addToActors(kate)
          
          movie1.year = Int16(1998)
          
          let movie2 = Movie(context: self.moc)
          movie2.title = "Jackie Brown"
          movie2.director = "Quentin Tarantino"
          
          let pam = Actor(context: self.moc)
          pam.name = "Pam Grier"
          let bridget = Actor(context: self.moc)
          bridget.name = "Bridget Fonda"
          
          movie2.addToActors(pam)
          movie2.addToActors(bridget)
          
          movie2.year = Int16(1997)
          
          let movie3 = Movie(context: self.moc)
          movie3.title = "No Time to Die"
          movie3.director = "Cary Joji Fukunaga"
          
          let daniel = Actor(context: self.moc)
          daniel.name = "Daniel Craig"
          let ana = Actor(context: self.moc)
          ana.name = "Ana de Armas"
          
          movie3.addToActors(daniel)
          movie3.addToActors(ana)
          
          movie3.year = Int16(2020)
        }) {
          Text("Add")
            .padding()
            .frame(width: 150)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        
        Button(action: {
          do {
            if self.moc.hasChanges {
              self.alertTitle = "Successfully Saved"
              self.alertMessage = "Your data is saved and updated on the Core Data."
              self.showingAlert = true
              try self.moc.save()
            }
          } catch {
            print(error.localizedDescription)
          }
        }) {
          Text("Save")
            .padding()
            .frame(width: 150)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        
      }
      
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
    }
    
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
