//
//  ContentView.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @FetchRequest(entity: User.entity(), sortDescriptors: [
    NSSortDescriptor(key: "name", ascending: true)
  ]) var users: FetchedResults<User>
  @ObservedObject var viewModel = ContentViewModel()
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(users, id: \.wrappedId) { user in
          NavigationLink(destination: DetailView(user: user)) {
            HStack(alignment: .center) {
              VStack(alignment: .leading) {
                Text(user.wrappedName)
                  .font(.headline)
                Text(user.wrappedCompany)
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }
              Spacer()
              VStack(alignment: .center) {
                Circle()
                  .foregroundColor(user.isActive ? Color.green : Color.red)
                  .frame(width: 10, height: 10)
                Text(user.isActive ? "Online" : "Offline")
                  .font(.footnote)
                  .foregroundColor(.secondary)
              }
            }
            .padding(8)
          }
        }
      }
      .navigationBarTitle("FriendFace")
    }
  }
  
}

struct ContentView_Day_60_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
