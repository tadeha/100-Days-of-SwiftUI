//
//  ContentView.swift
//  Moonshot
//
//  Created by Tadeh Alexani on 4/27/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// GeometryReader is a view just like the others we’ve used, except when we create it we’ll be handed a GeometryProxy object to use. This lets us query the environment: how big is the container? What position is our view? Are there any safe area insets? And so on.


// Scroll View -> Acts Immediately
// List        -> Acts Lazy

// Codable: its ability to decode a hierarchy of data in one pass is invaluable, which is why it’s central to so many Swift apps.

// NavigationLink requires a NavigationView to work.

import SwiftUI

struct ContentView: View {
  
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  @State private var showingCrews = false
  
  var body: some View {
    NavigationView {
      List(missions) { mission in
        NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
          Image(decorative: mission.image)
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
          
          VStack(alignment: .leading) {
            Text(mission.displayName)
              .font(.headline)
            Text(self.showingCrews ? mission.crews : mission.formattedLaunchDate)
          }
          .accessibilityElement(children: .ignore)
          .accessibility(label: self.showingCrews ? Text("\(mission.displayName). Crew: \(mission.crews)") : Text("\(mission.displayName). \(mission.formattedLaunchDate)"))
        }
        .accessibility(removeTraits: .isButton)
      }
      .navigationBarTitle("Moonshot")
      .navigationBarItems(trailing: Button("Toggle Details") {
        self.showingCrews.toggle()
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
