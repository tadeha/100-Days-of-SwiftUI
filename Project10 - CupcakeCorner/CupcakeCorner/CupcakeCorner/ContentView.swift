//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tadeh Alexani on 5/10/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Codable {
  enum CodingKeys: CodingKey {
    case name
  }
  
  @Published var name = "Tadeh Alexani"
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    
  }
}

struct ContentView: View {
  var body: some View {
    SongsList()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
