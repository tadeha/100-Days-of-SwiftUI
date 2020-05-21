//
//  ContentView_Day62.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/21/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView_Day62: View {
  
  @State private var blurAmount: CGFloat = 0
  @State private var backgroundColor = Color.white
  @State private var showingActionSheet = false
  
  var body: some View {
    let blur = Binding<CGFloat>(
      get: {
        return self.blurAmount
      },
      set: {
        self.blurAmount = $0
        print("New value is \(self.blurAmount)")
      }
    )
    
    return VStack {
      Text("Hello World!")
        .blur(radius: blurAmount)
        .frame(width: 300, height: 200)
        .background(backgroundColor)
        .onTapGesture {
          self.showingActionSheet = true
      }
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(title: Text("Change Background"), message: Text("Select a background color"), buttons: [
          .default(Text("Red")) {
            self.backgroundColor = .red
          },
          .default(Text("Blue")) {
            self.backgroundColor = .blue
          },
          .default(Text("Yellow")) {
            self.backgroundColor = .yellow
          },
          .cancel()
        ])
      }
      
      Slider(value: blur, in: 1...20)
      .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day62()
  }
}
