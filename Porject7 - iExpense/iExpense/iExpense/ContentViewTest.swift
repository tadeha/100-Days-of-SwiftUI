//
//  ContentView.swift
//  iExpense
//
//  Created by Tadeh Alexani on 4/24/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct SecondView: View {
  var name: String
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack {
      Text("Your username \(name) is saved!")
      Button("Close") {
        self.presentationMode.wrappedValue.dismiss()
      }
    }
  }
}

class User: ObservableObject {
  @Published var username = ""
}

struct ContentView: View {
  
  @ObservedObject private var user = User()
  @State private var showingSheet = false
  @State private var numbers = [Int]()
  @State private var currentNumber = 1
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          ForEach(numbers, id: \.self) { num in
            Text("\(num)")
          }
          .onDelete(perform: removeRows)
        }
        TextField("Enter your  username", text: $user.username)
          .padding()
        Button("Save") {
          self.numbers.append(self.currentNumber)
          self.currentNumber += 1
          self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
          SecondView(name: self.user.username)
        }
      }
      .navigationBarItems(trailing: EditButton())
    }
  }
  
  func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
