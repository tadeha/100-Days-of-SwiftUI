//
//  ResultsView.swift
//  RollDice
//
//  Created by Tadeh Alexani on 6/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
  
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: DiceResult.entity(), sortDescriptors: []) var results: FetchedResults<DiceResult>
  
  @EnvironmentObject var diceResults: DiceResults
  
  var body: some View {
    NavigationView {
      if diceResults.values.count == 0 {
        Text("Roll Dice first in the first tab to see the results here!")
        .foregroundColor(.secondary)
        .padding(50)
        .multilineTextAlignment(.center)
        .navigationBarTitle("Results")
      } else {
        List {
          ForEach(0..<diceResults.values.count) { index in
            Text("\(self.diceResults.values[index])")
          }
        }
        .navigationBarTitle("Results")
      }
    }
    .onAppear(perform: loadData)
  }
  
  func loadData() {
    diceResults.values = results.compactMap { Int($0.value) }
  }
  
}

struct ResultsView_Previews: PreviewProvider {
  static var previews: some View {
    ResultsView()
    .environmentObject(DiceResults())
  }
}
