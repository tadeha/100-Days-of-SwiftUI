//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tadeh Alexani on 6/13/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var cards = [Card](repeating: Card.example, count: 10)
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  
  @State private var timeRemaining = 100
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  @State private var isActive = true
  
  var body: some View {
    ZStack {
      
      Image("background")
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
            CardView(card: self.cards[index]) {
              withAnimation {
                self.removeCard(at: index)
              }
            }
            .stacked(at: index, in: self.cards.count)
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
      
      if differentiateWithoutColor {
        VStack {
          Spacer()
          
          HStack {
            Image(systemName: "xmark.circle")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
            Spacer()
            Image(systemName: "checkmark.circle")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
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
  }
  
  func removeCard(at index: Int) {
    cards.remove(at: index)
    
    if cards.isEmpty {
      isActive = false
    }
  }
  
  func resetCards() {
    cards = [Card](repeating: Card.example, count: 10)
    timeRemaining = 100
    isActive = true
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
