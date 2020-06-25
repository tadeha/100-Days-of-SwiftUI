//
//  ContentView.swift
//  RollDice
//
//  Created by Tadeh Alexani on 6/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
  var diceResults = DiceResults()
  
  var body: some View {
    TabView {
      DiceView()
        .tabItem {
          Image(systemName: "square.grid.2x2.fill")
            .accessibility(hidden: true)
            Text("Roll Dice")
        }
        
      ResultsView()
        .tabItem {
          Image(systemName: "star.circle.fill")
          .accessibility(hidden: true)
          Text("Results")
      }
    }
    .environmentObject(diceResults)
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    .environmentObject(DiceResults())
  }
}
