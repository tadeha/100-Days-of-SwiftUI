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
  @State private var numberOfQuestions = "5"
  let questionsCount = ["5", "10", "20", "All"]
  
  var body: some View {
    NavigationView {
      Form {
        Section(footer: Text("Select the level of difficulty")) {
          Stepper(value: $questionsUpTo, in: 1...12, step: 1) {
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
            NavigationLink(destination: GameView(questionsUpTo: questionsUpTo, numberOfQuestions: numberOfQuestions)) {
              Text("Let's Answer Some Questions!")
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

struct Question {
  let text: String
  let answer: Int
}

struct GameView: View {
  
  var questionsUpTo = 1
  var numberOfQuestions = "5"
  
  @State private var questions = [Question]()
  @State private var currentQuestion = 0
  @State private var currentAnswer = ""
  @State private var gameLoaded = false
  @State private var showingAlert = false
  @State private var userScore = 0

  let animals = ["bear", "buffalo", "elephant","chicken", "cow", "giraffe", "dog"]
  let colors: [Color] = [.blue,.red,.yellow,.green,.pink,.purple]
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  
  var body: some View {
    VStack {
      HStack(spacing: 25) {
        Image(animals[Int.random(in: 0..<animals.count)])
          .resizable()
          .scaledToFit()
          .frame(width: 75, height: 75)
          .animation(.default)
        
        Text(gameLoaded ? "What is \(self.questions[currentQuestion].text)?" : "Loading..")
               .font(.title)
               .fontWeight(.bold)
      }
      
      TextField(gameLoaded ? "\(self.questions[currentQuestion].text)?" : "Loading..", text: $currentAnswer)
        .font(.largeTitle)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(50)
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
      
      
      Button(action: {
        withAnimation {
          self.checkAnswer()
        }
      }, label: {
        Text("Check Answer")
          .font(.title)
          .fontWeight(.bold)
      })
      .frame(width: 300, height: 100)
      .background(colors[Int.random(in: 0..<colors.count)])
      .foregroundColor(.white)
      .clipShape(Capsule())
      
      Spacer()
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text("Game Finished!"), message: Text("Your score is \(self.userScore)"), dismissButton: .default(Text("OK"), action: {
        self.presentationMode.wrappedValue.dismiss()
      }))
    }
    .onAppear {
      self.generateQuestions()
    }
  }
  
  func generateQuestions() {
    if let numberOfQuestions = Int(numberOfQuestions) {
      
      for _ in 0...numberOfQuestions-1 {
        
        let firstNumber = Int.random(in: 1...questionsUpTo)
        let secondNumber = Int.random(in: 1...questionsUpTo)
                
        questions.append(Question(text: "\(firstNumber) x \(secondNumber)", answer: firstNumber*secondNumber))
      }
      
    } else {
      for _ in 0...((questionsUpTo*10)-1) {
        
        let firstNumber = Int.random(in: 1...questionsUpTo)
        let secondNumber = Int.random(in: 1...questionsUpTo)
                
        questions.append(Question(text: "\(firstNumber) x \(secondNumber)", answer: firstNumber*secondNumber))
      }
    }
    gameLoaded = true
  }
  
  func checkAnswer() {
    let userAnswer = Int(currentAnswer) ?? 0
    if questions[currentQuestion].answer == userAnswer {
      userScore += 1
    } else {
      userScore -= 1
    }
    
    if currentQuestion < questions.count - 1 {
      currentAnswer = ""
      currentQuestion += 1
    } else {
      gameLoaded = false
      currentQuestion = 0
      generateQuestions()
      showingAlert = true
    }
    
  }
  
}

struct ContentView: View {
  var body: some View {
    SettingsView()
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
