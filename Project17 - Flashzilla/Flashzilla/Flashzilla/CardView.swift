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
  
  let card: Card
  
  var removal: (() -> Void)? = nil
  
  @State private var isShowingAnswer = false
  @State private var offset = CGSize.zero
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.white)
        .shadow(radius: 10)
      
      VStack {
        Text(card.prompt)
          .font(.largeTitle)
          .foregroundColor(.black)
        
        if isShowingAnswer {
          Text(card.answer)
            .font(.title)
            .foregroundColor(.gray)
        }
        
      }
      .padding(20)
      .multilineTextAlignment(.center)
      
    }
    .frame(width: 450, height: 250)
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(Double(2 - abs(offset.width/50)))
    .gesture (
      DragGesture()
        .onChanged { gesture in
          self.offset = gesture.translation
      }
      .onEnded { _ in
        if abs(self.offset.width) > 100 {
          self.removal?()
        } else {
          self.offset = .zero
        }
      }
    )
    .onTapGesture {
      self.isShowingAnswer.toggle()
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
