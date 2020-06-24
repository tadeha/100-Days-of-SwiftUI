//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tadeh Alexani on 6/22/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct OuterView: View {
  var body: some View {
    VStack {
      Text("Top")
      InnerView()
        .background(Color.green)
      Text("Bottom")
    }
  }
}

struct InnerView: View {
  var body: some View {
    HStack {
      Text("Left")
      GeometryReader { geo in
        Text("Center")
          .background(Color.blue)
          .onTapGesture {
            print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
            print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
            print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
        }
      }
      .background(Color.orange)
      Text("Right")
    }
  }
}

struct HelixSpin: View {
  
  let colors: [Color] = [.pink, .blue, .red, .yellow, .purple, .green, .orange]
  
  var body: some View {
    GeometryReader { fullView in
      ScrollView(.vertical) {
        ForEach(0..<50) { index in
          GeometryReader { geo in
            Text("Row #\(index)")
              .font(.title)
              .frame(width: fullView.size.width)
              .background(self.colors[index % 7])
              .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
            
          }
          .frame(height: 40)
        }
      }
    }
  }
}

struct CoverFlowScroll: View {
  
  let colors: [Color] = [.pink, .blue, .red, .yellow, .purple, .green, .orange]
  
  var body: some View {
    GeometryReader { fullView in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(0..<50) { index in
            GeometryReader { geo in
              Rectangle()
                .fill(self.colors[index % 7])
                .frame(height: 150)
                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
            }
            .frame(width: 150)
          }
        }
        .padding(.horizontal, (fullView.size.width - 150) / 2)
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView: View {
  
  @State private var selectedView = 0
  
  var body: some View {
    
    VStack {
      Picker(selection: $selectedView, label: Text("Which view to select?")) {
        Text("Helix Spin")
          .tag(0)
        Text("Cover Flow Scroll")
          .tag(1)
      }
      .pickerStyle(SegmentedPickerStyle())
      .labelsHidden()
      .padding()
      
      if selectedView == 0 {
        HelixSpin()
      } else {
        CoverFlowScroll()
      }
    }
    
    /*
     OuterView()
     .background(Color.red)
     .coordinateSpace(name: "Custom")
     */
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
