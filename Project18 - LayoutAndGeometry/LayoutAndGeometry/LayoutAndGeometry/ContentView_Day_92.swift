//
//  ContentView_Day_92.swift
//  LayoutAndGeometry
//
//  Created by Tadeh Alexani on 6/22/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

extension VerticalAlignment {
  
  enum MidAccountAndName: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
      d[.top]
    }
  }
  
  static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
  
}

struct ContentView_Day_92: View {
  var body: some View {
    // applying modifiers creates new views rather than just modifying existing views in-place.
    VStack(spacing: 10) {
      ZStack {
        Image("galina-n-189483")
          .frame(width: 300, height: 200)
        
        VStack(alignment: .leading) {
          Text("Hello, world!")
            .alignmentGuide(.leading) { d in d[.trailing] }
          Text("This is a longer line of text")
        }
        .background(Color.red)
        .frame(width: 300, height: 200)
      }
      
      Image("galina-n-189483")
        .resizable()
        .frame(width: 300, height: 200)
      
      HStack(alignment: .midAccountAndName) {
        VStack {
          Text("@tadeh19")
            .alignmentGuide(.midAccountAndName) { d in
              d[VerticalAlignment.center]
          }
          Image("galina-n-189483")
            .resizable()
            .frame(width: 64, height: 64)
        }
        
        VStack {
          Text("Full name:")
          Text("TADEH ALEXANI")
            .alignmentGuide(.midAccountAndName) { d in
              d[VerticalAlignment.center]
          }
          .font(.largeTitle)
        }
      }
    }
    
  }
}

struct ContentView_Day_92_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day_92()
  }
}
