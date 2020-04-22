//
//  ContentView.swift
//  Animations
//
//  Created by Tadeh Alexani on 4/19/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

/*
 
 Button("Tap Me") {
 withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
 self.animationAmount += 360
 }
 }
 .padding(50)
 .background(Color.red)
 .foregroundColor(.white)
 .clipShape(Circle())
 .rotation3DEffect(.degrees(animationAmount),
 axis: (x: 1, y: 1, z: 1))
 
 */

/*
 
 LinearGradient(gradient: Gradient(colors: [.yellow,.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
 .frame(width: 300, height: 200)
 .clipShape(RoundedRectangle(cornerRadius: 10))
 .offset(dragAmount)
 .gesture(
 DragGesture()
 .onChanged {
 self.dragAmount = $0.translation
 }
 .onEnded({ _ in
 withAnimation(.spring()) {
 self.dragAmount = .zero
 }
 })
 )
 
 */

/*
 
 var letters = Array("Sogand")
 @State private var enabled = false
 @State private var dragAmount = CGSize.zero
 
 HStack(spacing: 0) {
     ForEach(0 ..< letters.count) { num in
       Text(String(self.letters[num]))
         .padding(5)
         .font(.title)
         .background(self.enabled ? Color.blue : Color.red)
         .foregroundColor(.white)
         .offset(self.dragAmount)
         .animation(Animation.default.delay(Double(num) / 20))
     }
   }
 .gesture(
   DragGesture()
     .onChanged { self.dragAmount = $0.translation }
     .onEnded { _ in
       self.dragAmount = .zero
       self.enabled.toggle()
     }
   )
 
 */

/*
struct CornerRotateModifier: ViewModifier {
  let amount: Double
  let anchor: UnitPoint
  
  func body(content: Content) -> some View {
    content
      .rotationEffect(.degrees(amount), anchor: anchor)
    .clipped()
  }
}

extension AnyTransition {
  static var pivot: AnyTransition {
    .modifier(
      active: CornerRotateModifier(amount: -90, anchor: .topLeading),
      identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
    )
  }
}
*/

struct ContentView: View {
  
  var body: some View {
    Text("Hello World!")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
