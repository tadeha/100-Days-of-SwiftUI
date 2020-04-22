//
//  ContentView.swift
//  Temperature Conversion
//
//  Created by Tadeh Alexani on 4/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  let units = ["Celsius", "Fahrenheit", "Kelvin"]
  
  @State private var inputUnit = 0
  @State private var outputUnit = 1
  @State private var inputValue = ""
  
  var convertedValue: Double {
    
    let inputNumber = Double(inputValue) ?? 0

    var middleValue: Double = 0
    
    // Convert to Celsius
    switch units[inputUnit] {
      case "Celsius":
        // -
        middleValue = inputNumber
      case "Fahrenheit":
        // (32°F − 32) × 5/9 = 0°C
        middleValue = (inputNumber - 32) * 5/9
      case "Kelvin":
        // 0K − 273.15 = -273.1°C
        middleValue = inputNumber - 273.15
      default:
        break
    }
    
    var finalValue: Double = 0
    
    switch units[outputUnit] {
      case "Celsius":
        // -
        finalValue = middleValue
      case "Fahrenheit":
        // (0°C × 9/5) + 32 = 32°F
        finalValue = (middleValue * 9/5) + 32
      case "Kelvin":
        // 0°C + 273.15 = 273.15K
        finalValue = middleValue + 273.15
      default:
        break
    }
    
    return finalValue
    
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Choose the Input unit")) {
          Picker("Input unit", selection: $inputUnit) {
            ForEach(0 ..< units.count) {
              Text("\(self.units[$0])")
            }
          }
        .pickerStyle(SegmentedPickerStyle())
          
        }
        Section(header: Text("Choose the Output unit")) {
          Picker("Output unit", selection: $outputUnit) {
              ForEach(0 ..< units.count) {
                Text("\(self.units[$0])")
              }
            }
          .pickerStyle(SegmentedPickerStyle())
        }
        Section {
          TextField("Please enter the input value", text: $inputValue)
          .keyboardType(.decimalPad)
        }
        Section(header: Text("Here is the Converted value:")) {
          Text("\(convertedValue, specifier: "%.1f") \(units[outputUnit])")
        }
      }
    .navigationBarTitle("TempConv")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
