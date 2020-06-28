//
//  Facility.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/28/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct Facility: Identifiable {
  
  let id = UUID()
  var name: String
  
  var icon: some View {
    let icons = [
      "Accommodation": "house",
      "Beginners": "1.circle",
      "Cross-country": "map",
      "Eco-friendly": "leaf.arrow.circlepath",
      "Family": "person.3"
    ]
    
    if let iconName = icons[name] {
      
      let image = Image(systemName: iconName)
        .foregroundColor(.secondary)
        .accessibility(label: Text(name))
      return image
      
    } else {
      fatalError("Unknown facility type: \(name)")
    }
  }
  
  var alert: Alert {
    let messages = [
        "Accommodation": "This resort has popular on-site accommodation.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort has won an award for environmental friendliness.",
        "Family": "This resort is popular with families."
    ]
    
    if let message = messages[name] {
      return Alert(title: Text(name), message: Text(message))
    } else {
      fatalError("Unknown facility type: \(name)")
    }
  }
}
