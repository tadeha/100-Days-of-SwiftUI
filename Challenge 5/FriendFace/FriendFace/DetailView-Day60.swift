//
//  DetailView_Day_60.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct DetailView_Day_60: View {
  
  var users: [UserStruct]
  var user: UserStruct
  
  var body: some View {
    List {
      Section(header: Text("About \(user.name)")) {
        Text(user.about)
      }
      
      Section(header: Text("More Info")) {
        VStack(alignment: .leading, spacing: 10) {
          HStack {
            Text("Company:")
              .fontWeight(.bold)
              .font(.headline)
            Text(user.company)
          }
          
          HStack {
            Text("Email:")
              .fontWeight(.bold)
              .font(.headline)
            Text(user.email)
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
            Text(user.address)
          }
        }
        .padding([.vertical])
      }
      
      Section(header: Text("Friends")) {
        ForEach(user.friends, id: \.id) { friend in
          NavigationLink(destination: DetailView_Day_60(users: self.users, user: self.user(withId: friend.id) ?? self.user)) {
            Text(friend.name)
          }
        }
      }
    }
    .navigationBarTitle(Text(user.name), displayMode: .inline)
  }
  
  func user(withId id: String) -> UserStruct? {
    if let user = users.first(where: { $0.id == id }) {
      return user
    } else {
      return nil
    }
  }
}

