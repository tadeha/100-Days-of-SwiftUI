//
//  Prospect.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/9/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
  let id = UUID()
  var name = "Anonymous"
  var emailAddress = ""
  fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
  @Published fileprivate(set) var people: [Prospect]
  static let saveKey = "SavedData"
  
  init() {
    if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
      if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        people = decoded
        return
      }
    }
    people = []
  }
  
  private func save() {
    if let encoded = try? JSONEncoder().encode(people) {
      UserDefaults.standard.set(encoded, forKey: Self.saveKey)
    }
  }
  
  func add(_ prospect: Prospect) {
    people.append(prospect)
    save()
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
  }
}
