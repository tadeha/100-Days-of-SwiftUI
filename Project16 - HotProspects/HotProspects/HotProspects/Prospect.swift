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
  @Published var people: [Prospect]
  
  init() {
    self.people = []
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
  }
}
