//
//  DetailView.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
  
  @Environment(\.managedObjectContext) var moc
  var user: User
  
  var body: some View {
    List {
      Section(header: Text("About \(user.wrappedName)")) {
        Text(user.wrappedAbout)
      }
      
      Section(header: Text("More Info")) {
        VStack(alignment: .leading, spacing: 10) {
          HStack {
            Text("Company:")
              .fontWeight(.bold)
              .font(.headline)
            Text(user.wrappedCompany)
          }
          
          HStack {
            Text("Email:")
              .fontWeight(.bold)
              .font(.headline)
            Text(user.wrappedEmail)
          }
          HStack {
            Text("Age:")
              .fontWeight(.bold)
              .font(.headline)
            Text("\(user.age)")
          }
          HStack(alignment: .top) {
            Text("Address:")
              .fontWeight(.bold)
              .font(.headline)
            Text(user.wrappedAddress)
          }
        }
        .padding([.vertical])
      }
      
      Section(header: Text("Friends")) {
        
        if user.friendsArray.count != 0 {
          ForEach(user.friendsArray, id: \.wrappedId) { friend in
            NavigationLink(destination: DetailView(user: self.getFriendUser(friend: friend))) {
              Text(friend.wrappedName)
            }
          }
        } else {
          Text("\(user.wrappedName) has no friends!")
            .foregroundColor(.secondary)
        }
        
      }
    }
    .navigationBarTitle(Text(user.wrappedName), displayMode: .inline)
  }
  
  func getFriendUser(friend: Friend) -> User {
    let request: NSFetchRequest = User.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", friend.wrappedId)
    
    guard let users = try? moc.fetch(request) else {
      return User()
    }
    
    return users.first ?? User()
  }
}

