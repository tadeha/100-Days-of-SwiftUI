//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/27/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ResortView: View {
  
  let resort: Resort
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        Image(decorative: resort.id)
        .resizable()
        .scaledToFit()
        
        Group {
          
          HStack {
            Spacer()
            ResortDetailsView(resort: resort)
            SkiDetailsView(resort: resort)
            Spacer()
          }
          .font(.headline)
          .foregroundColor(.secondary)
          .padding(.top)
          
          Text(resort.description)
            .padding(.vertical)
          
          Text("Facilities:")
            .font(.headline)
          
          Text(ListFormatter.localizedString(byJoining: resort.facilities))
            .padding(.vertical)
        }
        .padding(.horizontal)
      }
    }
    .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
  }
}

struct ResortView_Previews: PreviewProvider {
  static var previews: some View {
    ResortView(resort: Resort.example)
  }
}
