//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tadeh Alexani on 4/6/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-decorative-images-to-reduce-screen-reader-clutter

import SwiftUI

struct FlagImage: View {
  var name: String
  
  var body: some View {
    Image(name)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: .black, radius: 2)
  }
}

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var scoreMessage = ""
  @State private var userScore = 0
  @State private var userTapped = 0
  @State private var animationAmount = 0.0
  @State private var opacity = 1.0
  @State private var offset = CGFloat.zero
  @State private var disabled = false
  
  @State var wrongAttempt: Bool = false
  
  // Returning some View means we must return exactly one view.
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text("\(countries[correctAnswer])")
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
        }
        
        ForEach(0 ..< 3) { number in
          Button(action: {
            if number == self.correctAnswer {
              self.flagTapped(number)
              self.userTapped = number
              withAnimation(.easeInOut(duration: 2)) {
                self.animationAmount += 360
                self.opacity -= 0.75
              }
            } else {
              self.flagTapped(number)
              self.userTapped = number
              withAnimation(.easeInOut(duration: 0.5)) {
                self.offset = 200
              }
            }
            self.disabled = true
          }) {
            FlagImage(name: self.countries[number])
          }
          .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: number == self.userTapped ? 1 : 0, z: 0))
              .offset(x: number != self.correctAnswer ? self.offset : .zero, y: .zero)
              .clipped()
              .opacity(number != self.userTapped ? self.opacity : 1.0)
              .disabled(self.disabled)
          

        }
        
        
        Text("Your Score is \(userScore)")
          .foregroundColor(.white)
        
        Spacer()
      }
    }
    .alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
        self.askQuestion()
        })
    }
  }
  
  func askQuestion() {
    self.disabled = false
    self.opacity = 1
    self.offset = .zero
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    wrongAttempt = false
  }
  
  func flagTapped(_ number: Int) {
    
    if number == correctAnswer {
      scoreTitle = "Correct Answer"
      userScore += 1
      scoreMessage = "Congrats! Your Score is \(userScore)."
    } else {
      wrongAttempt = true
      scoreTitle = "Wrong Answer"
      userScore -= 1
      scoreMessage = "Wrong! That’s the flag of \(countries[number])."
    }
    
    self.showingScore = true
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
