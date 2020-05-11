//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tadeh Alexani on 5/10/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

/*
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
*/

struct ContentView: View {
  
  @ObservedObject var order = Order()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Select Your Cupcake Type", selection: $order.type) {
            ForEach(0 ..< Order.types.count, id: \.self) {
              Text(Order.types[$0])
            }
          }
          Stepper(value: $order.quantity, in: 3...20) {
            Text("Number of cakes: \(order.quantity)")
          }
        }
        Section {
          Toggle(isOn: $order.specialRequestEnabled.animation()) {
            Text("Any special requests?")
          }
          if order.specialRequestEnabled {
            Toggle(isOn: $order.extraFrosting) {
              Text("Add extra frosting")
            }
            Toggle(isOn: $order.addSprinkles) {
              Text("Add extra sprinkles")
            }
          }
        }
        Section {
          NavigationLink(destination: AddressView(order: order)) {
            Text("Delivery Details")
          }
        }
      }
    .navigationBarTitle("Cupcake Corner")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
