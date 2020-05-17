//
//  Actor+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Tadeh Alexani on 5/17/20.
//  Copyright © 2020 Alexani. All rights reserved.
//
//

import Foundation
import CoreData


extension Actor {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Actor> {
    return NSFetchRequest<Actor>(entityName: "Actor")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var movie: Movie?
  
  public var wrappedName: String {
    name ?? "Unknown Actor"
  }
}
