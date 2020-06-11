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
  var dateAdded = Date()
  fileprivate(set) var isContacted = false
  
  enum SortOption {
    case name, mostRecent
  }
}

class Prospects: ObservableObject {
  @Published fileprivate(set) var people: [Prospect]
  static let saveKey = "SavedData"
  
  init() {
    /*
    if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
      if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        people = decoded
        return
      }
    }
    */
    let url = FileManager.getDocumentsDirectory().appendingPathComponent(Self.saveKey)

    if let data = try? Data(contentsOf: url) {
      if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        people = decoded
        return
      }
    }
    people = []
  }
  
  private func save() {
    if let encoded = try? JSONEncoder().encode(people) {
      let url = FileManager.getDocumentsDirectory().appendingPathComponent(Self.saveKey)
      
      do {
        try encoded.write(to: url, options: [.atomic, .completeFileProtection])
      } catch {
        print(error.localizedDescription)
      }
      
      // UserDefaults.standard.set(encoded, forKey: Self.saveKey)
    }
  }
  
  func add(_ prospect: Prospect) {
    people.append(prospect)
    save()
  }
  
  func sort(by option: Prospect.SortOption) {
    switch option {
      case .name:
        people.sort { $0.name < $1.name }
      case .mostRecent:
        people.sort { $0.dateAdded < $1.dateAdded }
    }
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
  }
    
}
