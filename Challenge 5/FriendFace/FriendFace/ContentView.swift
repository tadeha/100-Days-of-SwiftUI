//
//  ContentView.swift
//  FriendFace
//
//  Created by Tadeh Alexani on 5/20/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var users = [User]()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(users, id: \.id) { user in
          NavigationLink(destination: DetailView(users: self.users, user: user)) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                  Text(user.name)
                    .font(.headline)
                  Text(user.company)
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
      .onAppear(perform: getUsers)
    }
  }
  
  // Error Handling using JSONDecoder: https://stackoverflow.com/a/55391123/7052287
  
  func getUsers() {
    
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
      return
    }
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      
      if let data = data {
        do {
          
          let decoder = JSONDecoder()
          let decoded = try decoder.decode([User].self, from: data)
          self.users = decoded
          
        } catch let DecodingError.dataCorrupted(context) {
          print(context)
        } catch let DecodingError.keyNotFound(key, context) {
          print("Key '\(key)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
          print("Value '\(value)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
          print("Type '\(type)' mismatch:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch {
          print("error: ", error)
        }
      }
      
    }.resume()
    
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
