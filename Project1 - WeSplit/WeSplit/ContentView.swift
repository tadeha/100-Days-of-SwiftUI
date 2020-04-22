//
//  ContentView.swift
//  WeSplit
//
//  Created by Tadeh Alexani on 4/1/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = ""
  @State private var numberOfPeople = ""
  @State private var tipPercentage = 2
  
  let tipPercentages = [10, 15, 20, 25, 0]
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople) ?? 0
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0
    
    let tipValue = (orderAmount / 100) * tipSelection
    let grandTotal = orderAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson

  }
  
  var totalAmount: Double {
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0
    
    let tipValue = (orderAmount / 100) * tipSelection
    let grandTotal = orderAmount + tipValue
    
    return grandTotal
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          
          TextField("Number of People", text: $numberOfPeople)
            .keyboardType(.numberPad)
        }
        
        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach ( 0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }
        .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Amount Per Person")) {
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }
          
        Section(header: Text("Total Amount of Check")) {
          Text("$\(totalAmount, specifier: "%.2f")")
            .foregroundColor(tipPercentage == 4 ? .red : .primary)
        }
        
      .navigationBarTitle("WeSplit")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
