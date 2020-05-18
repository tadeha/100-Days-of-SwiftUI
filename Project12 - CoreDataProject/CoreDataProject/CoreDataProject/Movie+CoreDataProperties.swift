//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Tadeh Alexani on 5/17/20.
//  Copyright © 2020 Alexani. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
    return NSFetchRequest<Movie>(entityName: "Movie")
  }
  
  @NSManaged public var director: String?
  @NSManaged public var title: String?
  @NSManaged public var year: Int16
  @NSManaged public var actors: NSSet?
  
  public var wrappedTitle: String {
    title ?? "Unknown Title"
  }
  
  public var wrappedDirector: String {
    director ?? "Unknown Director"
  }
  
  public var wrappedYear: String {
    "\(Int(year))"
  }
  
  public var actorArray: [Actor] {
    
    let set = actors as? Set<Actor> ?? []
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
  
}

// MARK: Generated accessors for actors
extension Movie {
  
  @objc(addActorsObject:)
  @NSManaged public func addToActors(_ value: Actor)
  
  @objc(removeActorsObject:)
  @NSManaged public func removeFromActors(_ value: Actor)
  
  @objc(addActors:)
  @NSManaged public func addToActors(_ values: NSSet)
  
  @objc(removeActors:)
  @NSManaged public func removeFromActors(_ values: NSSet)
  
}
