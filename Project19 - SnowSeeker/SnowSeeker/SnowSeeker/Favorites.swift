//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/28/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
  
  private var resorts: Set<String>
  private var saveKey = "Favorites"
  
  init() {
    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
        resorts = decoded
        return
      }
    }
    
    self.resorts = []
  }
  
  func contains(_ resort: Resort) -> Bool {
    resorts.contains(resort.id)
  }
  
  func add(_ resort: Resort) {
    objectWillChange.send()
    resorts.insert(resort.id)
    save()
  }
  
  func remove(_ resort: Resort) {
    objectWillChange.send()
    resorts.remove(resort.id)
    save()
  }
  
  func save() {
    if let encoded = try? JSONEncoder().encode(resorts) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }
  }
  
}
