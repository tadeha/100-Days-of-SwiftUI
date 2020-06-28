//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// Views can be given a height of 0.
// This is helpful to make spacers work only in a single direction.

// If we place views inside a Group the parent view decides how those views should be laid out.
// This happens because Group is layout neutral.

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var favorites = Favorites()
  let resorts: [Resort] = Bundle.main.decode("resorts.json")
  
  var body: some View {
    NavigationView {
      List(resorts) { resort in
        NavigationLink(destination: ResortView(resort: resort) ) {
          Image(resort.country)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 25)
            .clipShape(
              RoundedRectangle(cornerRadius: 5)
          )
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1)
          )
          
          VStack(alignment: .leading) {
            Text(resort.name)
              .font(.headline)
            Text("\(resort.runs) runs")
              .foregroundColor(.secondary)
          }
          .layoutPriority(1)
          
          if self.favorites.contains(resort) {
            Spacer()
            Image(systemName: "heart.fill")
              .foregroundColor(.red)
              .accessibility(label: Text("This is a favorite resort"))
          }
        }
      }
      .navigationBarTitle("Resorts")
      
      WelcomeView()
    }
    .environmentObject(favorites)
    // .phoneOnlyStackNavigationView()
  }
}

extension View {
  func phoneOnlyStackNavigationView() -> some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
    } else {
      return AnyView(self)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Favorites())
  }
}
