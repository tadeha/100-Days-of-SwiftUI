//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/27/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ResortView: View {
  
  @Environment(\.horizontalSizeClass) var sizeClass
  @EnvironmentObject var favorites: Favorites
  @State private var selectedFacility: Facility?
  
  let resort: Resort
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        ZStack(alignment: .bottomTrailing) {
          Image(decorative: resort.id)
          .resizable()
          .scaledToFit()
          
          Text("© \(resort.imageCredit)")
          .font(.caption)
          .foregroundColor(.white)
          .padding(6)
          .background(Color.black.opacity(0.5))
          .clipShape(Capsule())
          .offset(x: -5, y: -5)
          
        }
        
        Group {
          HStack {
            if sizeClass == .compact {
              Spacer()
              VStack {
                ResortDetailsView(resort: resort)
              }
              VStack {
                SkiDetailsView(resort: resort)
              }
              Spacer()
            } else {
              ResortDetailsView(resort: resort)
              Spacer().frame(height: 0)
              SkiDetailsView(resort: resort)
            }
            
          }
          .font(.headline)
          .foregroundColor(.secondary)
          .padding(.top)
          
          Text(resort.description)
            .padding(.vertical)
          
          Text("Facilities:")
            .font(.headline)
          
          // Text(ListFormatter.localizedString(byJoining: resort.facilities))
          HStack {
            ForEach(resort.facilityTypes) { facility in
              facility.icon
                .font(.title)
                .onTapGesture {
                  self.selectedFacility = facility
              }
            }
          }
          .padding(.vertical)
        }
        .padding(.horizontal)
      }
      Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
        if self.favorites.contains(self.resort) {
          self.favorites.remove(self.resort)
        } else {
          self.favorites.add(self.resort)
        }
      }
      .padding()
    }
    .alert(item: $selectedFacility) { facility in
      facility.alert
    }
    .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
  }
}

//extension String: Identifiable {
//  public var id: String { self }
//}

struct ResortView_Previews: PreviewProvider {
  static var previews: some View {
    ResortView(resort: Resort.example).environmentObject(Favorites())
  }
}
