//
//  CardView.swift
//  Flashzilla
//
//  Created by Tadeh Alexani on 6/16/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

extension View {
  func stacked(at position: Int, in total: Int) -> some View {
    let offset = CGFloat(total - position)
    return self.offset(CGSize(width: 0, height: offset * 10))
  }
}

struct CardView: View {
  
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  @Environment(\.accessibilityEnabled) var accessibilityEnabled

  let card: Card
    
  @State private var isShowingAnswer = false
  @State private var offset = CGSize.zero
  @State private var feedback = UINotificationFeedbackGenerator()
  
  // If closures are the last property in the struct Swift will enable trailing closure syntax automatically.
  var removal: (() -> Void)? = nil
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(
          differentiateWithoutColor ?
            Color.white
            : Color.white
              .opacity(1 - Double(abs(offset.width / 50)))
      )
        .background(
          differentiateWithoutColor ?
            nil
            : RoundedRectangle(cornerRadius: 25)
              .fill(offset.width > 0 ? Color.green : Color.red)
      )
        .shadow(radius: 10)
      
      VStack {
        if accessibilityEnabled {
          Text(isShowingAnswer ? card.answer : card.prompt)
            .font(.largeTitle)
            .foregroundColor(.black)
        } else {
          Text(card.prompt)
            .font(.largeTitle)
            .foregroundColor(.black)
          
          if isShowingAnswer {
            Text(card.answer)
              .font(.title)
              .foregroundColor(.gray)
          }
        }
        
      }
      .padding(20)
      .multilineTextAlignment(.center)
  
    }
    .frame(width: 450, height: 250)
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(Double(2 - abs(offset.width/50)))
    .accessibility(addTraits: .isButton)
    .gesture (
      DragGesture()
        .onChanged { gesture in
          self.offset = gesture.translation
          self.feedback.prepare()
      }
      .onEnded { _ in
        if abs(self.offset.width) > 100 {
          
          if self.offset.width > 0 {
            self.feedback.notificationOccurred(.success)
          } else {
            self.feedback.notificationOccurred(.error)
          }
          
          self.removal?()
          
        } else {
          self.offset = .zero
        }
      }
    )
      .onTapGesture {
        self.isShowingAnswer.toggle()
    }
    .animation(.spring())
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
