//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
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
        }
      }
      .navigationBarTitle("Resorts")
      
      WelcomeView()
    }
    .phoneOnlyStackNavigationView()
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
    ContentView()
  }
}
