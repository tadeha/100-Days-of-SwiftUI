//
//  ContentView.swift
//  Rock, paper, scissors
//
//  Created by Tadeh Alexani on 4/12/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  let moves = ["Rock", "Paper", "Scissors"]
  @State private var currentAppChoice = Int.random(in: 0 ..< 3)
  @State private var shouldWin = Bool.random()
  @State private var userScore = 0
  @State private var currentStep = 1
  @State private var showingAlert = false
  
  var body: some View {
    ZStack {
      Color.blue.edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 25) {
      
        Text("Steps: \(currentStep)/10")
          .font(.title)
        Text("Your score is: \(userScore)")
          .font(.title)
        Text(moves[currentAppChoice])
          .font(.largeTitle)
        Text(shouldWin ? "Win" : "Lose")
          .font(.largeTitle)
          .fontWeight(.bold)
        HStack(spacing: 8) {
          ForEach(0 ..< moves.count) { moveId in
            
            Button(action: {
              
              if self.currentStep == 10 {
                self.currentStep = 0
                self.userScore = 0
                self.showingAlert = true
              } else {
                self.calculateScore(withMove: moveId)
              }
              
            }) {
              Text("\(self.moves[moveId])")
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(Color.red)
            .clipShape(Capsule())
              
            .alert(isPresented: self.$showingAlert) {
              Alert(title: Text("Game Finished"), message: Text("Your final score is \(self.userScore)"), dismissButton: .default(Text("Got it!")))
            }
          }
        }
      }
      .foregroundColor(.white)
    }
    
    
  }
  
  func calculateScore(withMove currentUserChoice: Int) {
    if currentAppChoice == currentUserChoice {
      userScore += 0
    } else if shouldWin {
      
      switch currentAppChoice {
        case 0:
          if currentUserChoice == 1 {
            userScore += 1
          } else {
            userScore -= 1
        }
        case 1:
          if currentUserChoice == 2 {
            userScore += 1
          } else {
            userScore -= 1
        }
        case 2:
          if currentUserChoice == 0 {
            userScore += 1
          } else {
            userScore -= 1
        }
        default:
          break
        
      }
      
    } else {
      switch currentAppChoice {
        case 0:
          if currentUserChoice == 2 {
            userScore += 1
          } else {
            userScore -= 1
        }
        case 1:
          if currentUserChoice == 0 {
            userScore += 1
          } else {
            userScore -= 1
        }
        case 2:
          if currentUserChoice == 1 {
            userScore += 1
          } else {
            userScore -= 1
        }
        default:
          break
        
      }
    }
    currentAppChoice = Int.random(in: 0 ..< 3)
    shouldWin = Bool.random()
    currentStep += 1
  }
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
  
}
