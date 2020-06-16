//
//  Card.swift
//  Flashzilla
//
//  Created by Tadeh Alexani on 6/16/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

struct Card {
  let prompt: String
  let answer: String
  
  static var example: Card {
    Card(prompt: "Who is the captain of Real Madrid?", answer: "Sergio Ramos")
  }
}
