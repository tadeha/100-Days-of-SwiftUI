//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Tadeh Alexani on 5/17/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreData

enum FilteredListPredicate: String {
  case beginsWith = "BEGINSWITH"
  case contains = "CONTAINS"
  case equal = "=="
}

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
  
  init(filterKey: String, filterValue: String, filterOperator: FilteredListPredicate, sortDescriptors: [NSSortDescriptor],  @ViewBuilder content: @escaping (T) -> Content) {
    print(filterValue)
    fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filterOperator.rawValue) %@", filterKey, filterValue))
    self.content = content
  }
}
