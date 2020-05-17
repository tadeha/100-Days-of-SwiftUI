//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Tadeh Alexani on 5/17/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
  
  var fetchRequest: FetchRequest<T>
  var movies: FetchedResults<T> {
    fetchRequest.wrappedValue
  }
  
  let content: (T) -> Content
  
  var body: some View {
    List {
      ForEach(movies, id: \.self) { movie in
        self.content(movie)
      }
    }
  }
  
  init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
    fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: nil)
//    NSPredicate(format: "%K == %@", filterKey, filterValue)
    self.content = content
  }
}
