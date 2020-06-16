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
  @State private var isShowingAnswer = false
    
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
