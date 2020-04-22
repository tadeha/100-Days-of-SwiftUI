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
  
  let animationLength = 1.0
  
  @State private var opacities = [ 1.0, 1.0, 1.0 ]
  @State private var rotateAmounts = [ 0.0, 0.0, 0.0 ]
  
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
            self.flagTapped(number)
          }) {
            FlagImage(name: self.countries[number])
          }
          .offset(x: self.wrongAttempt ? -10 : 0)
          .animation(Animation.default.repeatCount(5))
          .rotation3DEffect(.degrees(self.rotateAmounts[number]), axis: (x: 0, y: 1, z: 0))
          .opacity(self.opacities[number])
          .animation(Animation.easeIn(duration: self.animationLength))
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
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    opacities = [ 1.0, 1.0, 1.0 ]
    rotateAmounts = [ 0.0, 0.0, 0.0 ]
    wrongAttempt = false
  }
  
  func flagTapped(_ number: Int) {
    
    if number == correctAnswer {
      rotateAmounts[number] = 360
      
      rotateAmounts.indices.forEach{
        if $0 != correctAnswer {
          rotateAmounts[$0] = 0
        }
      }
      
      opacities.indices.forEach{
        if $0 != correctAnswer {
          opacities[$0] = 0.25
        }
      }
      
      scoreTitle = "Correct Answer"
      userScore += 1
      scoreMessage = "Congrats! Your Score is \(userScore)."
    } else {
      wrongAttempt = true
      scoreTitle = "Wrong Answer"
      userScore -= 1
      scoreMessage = "Wrong! That’s the flag of \(countries[number])."
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + animationLength) { self.showingScore = true}
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
