//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//
//

import Foundation
import CoreData


extension User {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
    return NSFetchRequest<User>(entityName: "User")
  }
  
  @NSManaged public var id: String?
  @NSManaged public var name: String?
  @NSManaged public var age: Int16
  @NSManaged public var company: String?
  @NSManaged public var email: String?
  @NSManaged public var about: String?
  @NSManaged public var registered: Date?
  @NSManaged public var isActive: Bool
  @NSManaged public var address: String?
  @NSManaged public var friends: NSSet?
  
  
  public var wrappedId: String {
    id ?? "Unknown Id"
  }
  
  public var wrappedName: String {
    name ?? "Unknown Name"
  }
  
  public var wrappedCompany: String {
    company ?? "Unknown Company"
  }
  
  public var wrappedEmail: String {
    email ?? "N/A"
  }
  
  public var wrappedAbout: String {
    about ?? "N/A"
  }
  
  var wrappedRegistered: Date {
    registered ?? Date()
  }
  
  public var wrappedAddress: String {
    address ?? "Unknown Address"
  }
  
  public var friendsArray: [Friend] {
    let set = friends as? Set<Friend> ?? []
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
  
}

// MARK: Generated accessors for friends
extension User {
  
  @objc(addFriendsObject:)
  @NSManaged public func addToFriends(_ value: Friend)
  
  @objc(removeFriendsObject:)
  @NSManaged public func removeFromFriends(_ value: Friend)
  
  @objc(addFriends:)
  @NSManaged public func addToFriends(_ values: NSSet)
  
  @objc(removeFriends:)
  @NSManaged public func removeFromFriends(_ values: NSSet)
  
}
