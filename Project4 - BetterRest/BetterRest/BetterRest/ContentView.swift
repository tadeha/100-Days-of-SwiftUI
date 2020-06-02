//
//  ContentView.swift
//  BetterRest
//
//  Created by Tadeh Alexani on 4/13/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  
  private var calculatedBedtime: String {
    let model = SleepCalculator()
    
    let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
    let hour = (components.hour ?? 0) * 60 * 60
    let minute = (components.minute ?? 0) * 60
    
    do {
      let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      
      let sleepTime = wakeUp - prediction.actualSleep
      
      let formatter = DateFormatter()
      formatter.timeStyle = .short
      
      return formatter.string(from: sleepTime)
      
    } catch {
      alertTitle = "Error"
      alertMessage = "An error occured, please try again."
      
      showingAlert = true
      
      return ""
    }
    
    
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("When do you want to wake up?")) {
          
          DatePicker("Please enter a time", selection: $wakeUp,displayedComponents: .hourAndMinute)
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
        }
        
        
        Section(header: Text("Desired amount of sleep")) {
          
          Stepper(value:$sleepAmount ,in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
          }
          .accessibility(value: Text("\(sleepAmount, specifier: "%g") hours"))
        }
        
        Section(header: Text("Daily coffee intake")) {
          
          Picker(selection: $coffeeAmount,label: Text("")) {
            ForEach(1 ..< 20) {
              Text("\($0)")
            }
          }
          .labelsHidden()
          .pickerStyle(WheelPickerStyle())
        
        }
        
        Section(footer: Text("Your Recommended Bedtime")) {
          Text(calculatedBedtime)
            .font(.largeTitle)
        }
        
      }
      .navigationBarTitle("BetterRest")
        .alert(isPresented: $showingAlert) {
          Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
      }
    }
    
  }
  
  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 8
    components.minute = 0
    
    return Calendar.current.date(from: components) ?? Date()
  }
  

  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
