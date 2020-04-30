//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tadeh Alexani on 4/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
  let id = UUID()
  let name: String
  let type: String
  let amount: Int
}
