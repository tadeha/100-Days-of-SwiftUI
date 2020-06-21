//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tadeh Alexani on 6/13/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreHaptics

enum Sheets {
  case edit, settings
}

struct ContentView: View {
  
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  @Environment(\.accessibilityEnabled) var accessibilityEnabled
  
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  @State private var cards = [Card]()
  @State private var timeRemaining = 100
  @State private var isActive = true
  @State private var showingSheet = false
  @State private var sheetType: Sheets = .edit
  @State private var showingAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var engine: CHHapticEngine?
  @State private var isAnswerWrong = false
  
  let settings = UserSettings()
  
  var body: some View {
    ZStack {
      
      Image(decorative: "background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        
        Text("Time: \(timeRemaining)")
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 5)
          .background(
            Capsule()
              .fill(Color.black)
              .opacity(0.75)
        )
        
        ZStack {
          ForEach(0..<cards.count, id: \.self) { index in
            CardView(card: self.cards[index]) { isAnswerWrong in
              withAnimation {
                self.isAnswerWrong = isAnswerWrong
                self.removeCard(at: index)
              }
            }
            .stacked(at: index, in: self.cards.count)
            .allowsHitTesting(index == self.cards.count - 1)
            .accessibility(hidden: index < self.cards.count - 1)
          }
        }
        .allowsHitTesting(timeRemaining > 0)
        
        if cards.isEmpty {
          Button("Start Again", action: resetCards)
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
            .clipShape(Capsule())
        }
        
      }
      
      VStack {
        HStack {
          Button(action: {
            self.sheetType = .settings
            self.showingSheet = true
          }) {
            Image(systemName: "gear")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
          }
          
          Spacer()
          
          Button(action: {
            self.sheetType = .edit
            self.showingSheet = true
          }) {
            Image(systemName: "plus.circle")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
          }
        }
        
        Spacer()
      }
      .foregroundColor(.white)
      .font(.largeTitle)
      .padding()
      
      if differentiateWithoutColor || accessibilityEnabled {
        VStack {
          Spacer()
          
          HStack {
            Button(action: {
              withAnimation {
                self.removeCard(at: self.cards.count - 1)
              }
            }, label: {
              Image(systemName: "xmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            })
              .accessibility(label: Text("Wrong"))
              .accessibility(hint: Text("Mark your answer as being incorrect."))
            
            Spacer()
            
            Button(action: {
              withAnimation {
                self.removeCard(at: self.cards.count - 1)
              }
            }, label: {
              Image(systemName: "checkmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            })
              .accessibility(label: Text("Correct"))
              .accessibility(hint: Text("Mark your answer as being correct."))
            
          }
          .foregroundColor(.white)
          .font(.largeTitle)
          .padding()
        }
      }
      
    }
    .onReceive(timer) { timer in
      guard self.isActive else {
        return
      }
      
      if self.timeRemaining > 0 {
        self.timeRemaining -= 1
      } else {
        self.isActive = false
        self.alertTitle = "Time Finished!"
        self.alertMessage = "You can start again if you want"
        self.complexSuccess()
        self.showingAlert = true
      }
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
      self.isActive = false
    }
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
      if self.cards.isEmpty == false {
        self.isActive = true
      }
    }
    .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
      if self.sheetType == .edit {
        EditCards()
      } else {
        SettingsView().environmentObject(self.settings)
      }
      
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
    }
    .onAppear(perform: resetCards)
  }
  
  func removeCard(at index: Int) {
    guard index >= 0 else {
      return
    }
    
    let tempCard = cards.remove(at: index)
    
    if settings.stopRemovingCards && isAnswerWrong {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.cards.insert(tempCard, at: 0)
      }
    }
    
    if cards.isEmpty {
      isActive = false
    }
  }
  
  func resetCards() {
    timeRemaining = 100
    isActive = true
    loadData()
    prepareHaptics()
  }
  
  func loadData() {
    if let data = UserDefaults.standard.data(forKey: "Cards") {
      if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
        self.cards = decoded
      }
    }
  }
  
  func prepareHaptics() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
    do {
      self.engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("There was an error creating the engine: \(error.localizedDescription)")
    }
  }
  
  func complexSuccess() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()
    
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    events.append(event)
    
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern: \(error.localizedDescription).")
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
