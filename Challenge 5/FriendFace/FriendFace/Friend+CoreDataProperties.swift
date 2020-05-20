//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {
  
  enum CodingKeys: CodingKey {
    case id, name
  }
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
    return NSFetchRequest<Friend>(entityName: "Friend")
  }
  
  @NSManaged public var id: String?
  @NSManaged public var name: String?
  @NSManaged public var user: User?
  
  public var wrappedId: String {
    id ?? "Unknown Id"
  }
  
  public var wrappedName: String {
    name ?? "Unknown Name"
  }
  
}
