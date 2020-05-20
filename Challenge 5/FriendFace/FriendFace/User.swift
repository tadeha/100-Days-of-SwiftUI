//
//  User.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

struct User: Codable {
  
  enum CodingKeys: CodingKey {
    case id, name, age, company, email, address, about, registered, friends, isActive
  }
  
  struct Friend: Codable {
    var id: String
    var name: String
  }
  
  var id: String
  var name: String
  var age: Int
  var company: String
  var email: String
  var address: String
  var about: String
  var registered: String
  var friends: [Friend]
  var isActive: Bool
  
  var formattedRegisterDate: String {
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [
      .withFullDate
    ]
    
    if let realDate = isoDateFormatter.date(from: registered) {
      let dateFromatter = DateFormatter()
      dateFromatter.dateStyle = .short
      return dateFromatter.string(from: realDate)
    } else {
      return "N/A"
    }
  }

}
