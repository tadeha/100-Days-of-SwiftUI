//
//  Mission.swift
//  Moonshot
//
//  Created by Tadeh Alexani on 4/29/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }
  
  let id: Int
  let launchDate: Date?
  let crew: [CrewRole]
  let description: String

  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  var displayName: String {
    return "Apollo \(id)"
  }
  
  var image: String {
      "apollo\(id)"
  }
  
  var formattedLaunchDate: String {
    if let launchDate = launchDate {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter.string(from: launchDate)
    } else {
      return "N/A"
    }
  }
  
  var crews: String {
    var matches = [String]()
    for c in crew {
      if let match = astronauts.first(where: {$0.id == c.name}) {
        matches.append(match.name)
      }
    }
    return matches.joined(separator: ", ")
  }
}
