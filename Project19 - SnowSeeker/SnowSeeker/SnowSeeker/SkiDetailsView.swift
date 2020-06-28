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
    Group {
      Text("Elevation: \(resort.elevation)m").layoutPriority(1)
      Spacer().frame(height: 0)
      Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
    }
  }
}

struct SkiDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    SkiDetailsView(resort: Resort.example)
  }
}
