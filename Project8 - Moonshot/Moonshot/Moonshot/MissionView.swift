//
//  MissionView.swift
//  Moonshot
//
//  Created by Tadeh Alexani on 4/30/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct MissionView: View {
  
  struct CrewMember {
    let role: String
    let astronaut: Astronaut
  }
  
  let mission: Mission
  var astronauts = [CrewMember]()
  
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack {
          Image(decorative: self.mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geometry.size.width * 0.7)
          
          Text("Launch Date: \(self.mission.formattedLaunchDate)")
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.vertical)
          
          Text(self.mission.description)
            .padding()
          
          ForEach(self.astronauts, id: \.role) { crewMember in
            NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
              HStack {
                Image(decorative: crewMember.astronaut.id)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 80, height: 80)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(crewMember.role == "Commander" ? Color.yellow : Color.red, lineWidth: 3))
                
                VStack(alignment: .leading) {
                  Text(crewMember.astronaut.name)
                    .font(.headline)
                  
                  Text(crewMember.role)
                    .foregroundColor(Color.secondary)
                }
                
                
                Spacer()
              }
              .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
            .accessibility(removeTraits: .isButton)
          }
          
          Spacer(minLength: 25)
        }
      }
    }
    .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
  }
  
  init(mission: Mission, astronauts: [Astronaut]) {
    self.mission = mission
    var matches = [CrewMember]()
    
    for crew in mission.crew {
      if let match = astronauts.first(where: {$0.id == crew.name}) {
        matches.append(CrewMember(role: crew.role, astronaut: match))
      } else {
        fatalError("Missing crew named \(crew.name)")
      }
    }
    
    self.astronauts = matches
  }
}

struct MissionView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  
  static var previews: some View {
    MissionView(mission: missions[1], astronauts: astronauts)
  }
}
