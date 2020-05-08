//
//  Model.swift
//  HabitTracker
//
//  Created by Tadeh Alexani on 5/8/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

let userDefaultKey = "Activities"

struct Activity: Codable, Identifiable {
  let id = UUID()
  let title: String
  let description: String
}

class Activities: ObservableObject {
  @Published var items = [Activity]() {
    didSet {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: userDefaultKey)
      }
    }
  }
  
  init() {
    let decoder = JSONDecoder()
    if let data = UserDefaults.standard.data(forKey: userDefaultKey) {
      if let decoded = try? decoder.decode([Activity].self, from: data) {
        self.items = decoded
        return
      }
    }
    
    self.items = []
  }
}
