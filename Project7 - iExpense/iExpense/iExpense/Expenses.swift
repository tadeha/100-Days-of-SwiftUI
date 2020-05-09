//
//  Expenses.swift
//  iExpense
//
//  Created by Tadeh Alexani on 4/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

// @ObservedObject is the property wrapper, and ObservableObject is the protocol.

// @Published announces changes from a property; @ObservedObject watches an observed object for changes.

class Expenses: ObservableObject {
  @Published var items = [ExpenseItem]() {
    didSet {
      let encoder = JSONEncoder()
  
      if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: "Items")
      }
    }
  }
  
  init() {
    let decoder = JSONDecoder()
    if let items = UserDefaults.standard.data(forKey: "Items") {
      if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
        self.items = decoded
        return
      }
    }
    self.items = []
  }
}
