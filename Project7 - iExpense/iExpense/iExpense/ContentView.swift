//
//  ContentView.swift
//  iExpense
//
//  Created by Tadeh Alexani on 4/24/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var expenses = Expenses()
  @Environment(\.presentationMode) var presentationMode
  @State private var showingAddExpense = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items) { item in
          HStack {
            VStack(alignment: .leading) {
              Text(item.name)
                .font(.headline)
              Text(item.type)
            }
            Spacer()
            Text("$\(item.amount)")
              .foregroundColor(item.amount <= 10 ? .green : item.amount >= 100 ? .red : .yellow)
          }
        }
        .onDelete(perform: removeItems)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(leading:
        Button(action: {
          self.showingAddExpense = true
          
        }) {
          Image(systemName: "plus")
        }, trailing:
        EditButton()
      )
        
        .sheet(isPresented: $showingAddExpense) {
          AddView(expenses: self.expenses)
      }
    }
  }
  
  func removeItems(at offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
    expenses.items = expenses.items
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
