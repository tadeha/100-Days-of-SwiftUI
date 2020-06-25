//
//  DiceResults.swift
//  RollDice
//
//  Created by Tadeh Alexani on 6/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

class DiceResults: ObservableObject {
  @Published var values: [Int]
  
  init() {
    self.values = []
  }
}
