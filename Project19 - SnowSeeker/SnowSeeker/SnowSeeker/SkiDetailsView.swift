//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/27/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct SkiDetailsView: View {
  let resort: Resort
  
  var body: some View {
    VStack {
      Text("Elevation: \(resort.elevation)m")
      Text("Snow: \(resort.snowDepth)cm")
    }
  }
}

struct SkiDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    SkiDetailsView(resort: Resort.example)
  }
}
