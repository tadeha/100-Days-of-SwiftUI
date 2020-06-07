//
//  ContentView_Day_81.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView_Day_81: View {
  
  @State private var backgroundColor = Color.red
  let possibleNumbers = Array(1...60)
  var results: String {
    let selected = possibleNumbers.random(7).sorted()
    let strings = selected.map(String.init)
    return strings.joined(separator: ", ")
  }
  
  var body: some View {
    VStack(spacing: 50) {
      
      Text(results)
      
      Button("Request Permission") {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
          if success {
            print("All set!")
          } else if let error = error {
            print(error.localizedDescription)
          }
        }
      }
      
      Button("Schedule Notification") {
        let content = UNMutableNotificationContent()
        content.title = "Feed the car"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
      }
      
      Text("Hello")
        .padding()
        .background(backgroundColor)
        .foregroundColor(.white)
      
      Text("Change Color")
        .padding()
        .contextMenu {
          Button(action: {
            self.backgroundColor = .red
          }) {
            Text("Red")
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(.red)
          }
          
          Button(action: {
            self.backgroundColor = .green
          }) {
            Text("Green")
          }
          
          Button(action: {
            self.backgroundColor = .blue
          }) {
            Text("Blue")
          }
      }
    }
  }
  
}

struct ContentView_Day_81_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day_81()
  }
}
