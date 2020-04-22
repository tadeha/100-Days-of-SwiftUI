//
//  ContentView.swift
//  Edutainment
//
//  Created by Tadeh Alexani on 4/22/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  
  @State private var questionsUpTo = 1
  @State private var numberOfQuestions = 5
  let questionsCount = [5, 10, 20]
  
  var body: some View {
    NavigationView {
      Form {
        Section(footer: Text("Select the level of difficulty")) {
          Stepper(value: $questionsUpTo, in: 1...11, step: 1) {
            Text("Questions Up to \(self.questionsUpTo)")
          }
        }
        
        Section(footer: Text("Select how many questions do you want to answer")) {
          Picker(selection: $numberOfQuestions, label: Text("")) {
            ForEach(self.questionsCount, id: \.self) { count in
              Text("\(count)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section {
          HStack {
            Spacer()
            Button("Let's Answer Some Questions!") {
                // answer questions
            }
            .frame(width: 350, height: 44, alignment: .center)
            .foregroundColor(.purple)
            .clipShape(Capsule())
            Spacer()
          }
        }

      }
    .navigationBarTitle("Settings")
    }
    
  }
}

struct Question{
  let text = ""
  let answer = 0
}

struct GameView: View {
  
//  let questions = []
  @State private var currentQuestion = 0
  
  var body: some View {
    Text("Game View")
  }
}

struct ContentView: View {
  
  @State private var isGameActive = false
  
  var body: some View {
    Group {
      if isGameActive {
        GameView()
      } else {
        SettingsView()
      }
    }
  }
  
  func generateQuestions() {
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
