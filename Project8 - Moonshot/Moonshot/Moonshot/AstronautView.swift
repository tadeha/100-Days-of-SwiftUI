//
//  AstronautView.swift
//  Moonshot
//
//  Created by Tadeh Alexani on 4/30/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
  
  let astronaut: Astronaut
  var missions: [Mission]
  
  var body: some View {
    GeometryReader { geometry in
      
      ScrollView(.vertical) {
        VStack {
          Image(decorative: self.astronaut.id)
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width)
          
          Text(self.astronaut.description)
            .padding()
          
          HStack {
            Text("Missions Went")
            .font(.title)
            .fontWeight(.bold)
            
            Spacer()
          }
          .padding(.horizontal)
            
          ForEach(self.missions, id: \.id) { mission in
            HStack {
              Image(decorative: mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
              
              VStack(alignment: .leading) {
                Text(mission.displayName)
                  .font(.headline)
                Text("Launch Date: \(mission.formattedLaunchDate)")
                  .font(.caption)
              }
              Spacer()
            }
            .padding(.horizontal)
          }
        }
      }
      
    }
    .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
  }
  
  init(astronaut: Astronaut, missions: [Mission]) {
    self.astronaut = astronaut
    
    var matches = [Mission]()
    for mission in missions {
      if let _ = mission.crew.first(where: {$0.name == astronaut.id}) {
        matches.append(mission)
      }
    }
    
    self.missions = matches
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static var previews: some View {
    AstronautView(astronaut: astronauts[0], missions: missions)
  }
}
