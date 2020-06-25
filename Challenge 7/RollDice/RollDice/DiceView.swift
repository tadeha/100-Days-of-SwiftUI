//
//  DiceView.swift
//  RollDice
//
//  Created by Tadeh Alexani on 6/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct DiceView: View {
  
  let colors: [Color] = [.blue, .green, .orange, .pink, .purple, .red, .yellow]
  
  @Environment(\.managedObjectContext) var moc
  
  @State private var showingSheet = false
  @State private var currentDice: Int?
  @EnvironmentObject var diceResults: DiceResults
  
  let generator = UINotificationFeedbackGenerator()
  var settings = UserSettings()
  
  @State private var timeRemaining = 4
  @State private var timer = Timer.publish(every: 0.15, on: .main, in: .common)
  
  @FetchRequest(entity: DiceResult.entity(), sortDescriptors: []) var results: FetchedResults<DiceResult>
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        
        Image(decorative: "dice-28")
          .resizable()
          .scaledToFit()
          .frame(maxHeight: 200)
        
        VStack {
          Text("Current Dice Number is")
          
          if currentDice != nil {
            Text("\(currentDice!)")
              .font(.largeTitle)
              .foregroundColor(colors.randomElement())
              .fontWeight(.black)
          } else {
            Text("-")
              .font(.largeTitle)
              .foregroundColor(.secondary)
          }
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: currentDice == nil ? Text("Roll dice once with the button below") : Text("Current Dice Number is \(currentDice!)"))
        
        Button(action: {
          self.instantiateTimer()
          _ = self.timer.connect()
        }, label: {
          Text("Roll Dice")
            .fontWeight(.bold)
            .frame(width: 150, height: 150)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .font(.title)
        })
          .padding(50)
        
        
        Text("Total rolled on the dice: \(results.count) times")
          .foregroundColor(.secondary)
          .font(.caption)
        Text("Number of dice sides: \(settings.diceSides)-sided")
          .foregroundColor(.secondary)
          .font(.caption)
        
        Spacer()
      }
      .navigationBarTitle("Roll Dice")
      .navigationBarItems(trailing: Button(action: {
        self.showingSheet = true
      }, label: {
        Image(systemName: "gear")
          .accessibility(label: Text("Settings"))
          .foregroundColor(.primary)
          .font(.title)
      }))
        .sheet(isPresented: $showingSheet) {
          SettingsView()
            .environmentObject(self.settings)
      }
      .onReceive(timer) { time in
        
        if self.timeRemaining > 0 {
          self.currentDice = Int.random(in: 1...self.settings.diceSides)
          self.timeRemaining -= 1
        } else {
          self.calcDice()
        }
      }
    }
  }
  
  func calcDice() {
    cancelTimer()
    timeRemaining = 4
    currentDice = Int.random(in: 1...settings.diceSides)
    diceResults.values.append(currentDice!)
    
    self.generator.notificationOccurred(.success)
    
    let diceResult = DiceResult(context: self.moc)
    diceResult.value = Int32(currentDice ?? 0)
    
    if moc.hasChanges {
      try? moc.save()
    }
  }
  
  func instantiateTimer() {
    self.timer = Timer.publish(every: 0.15, on: .main, in: .common)
    return
  }
  
  func cancelTimer() {
    self.timer.connect().cancel()
    return
  }
  
}

struct DiceView_Previews: PreviewProvider {
  static var previews: some View {
    DiceView()
      .environmentObject(DiceResults())
  }
}
