//
//  DiceResult+CoreDataProperties.swift
//  RollDice
//
//  Created by Tadeh Alexani on 6/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//
//

import Foundation
import CoreData


extension DiceResult {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceResult> {
    return NSFetchRequest<DiceResult>(entityName: "DiceResult")
  }
  
  @NSManaged public var value: Int32
  
  var wrappedValue: Int {
    Int(value)
  }
  
}
