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

// We should always change our user interface on the main thread.
// SwiftUI is smart enough to be a little flexible here, but it's still a good idea to use the main thread for changing any data that is directly shown in the UI.

struct ContentView: View {
  
  @ObservedObject var order = Order()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Select Your Cupcake Type", selection: $order.cupcakeOrder.type) {
            ForEach(0 ..< CupcakeOrder.types.count, id: \.self) {
              Text(CupcakeOrder.types[$0])
            }
          }
          Stepper(value: $order.cupcakeOrder.quantity, in: 3...20) {
            Text("Number of cakes: \(order.cupcakeOrder.quantity)")
          }
        }
        Section {
          Toggle(isOn: $order.cupcakeOrder.specialRequestEnabled.animation()) {
            Text("Any special requests?")
          }
          if order.cupcakeOrder.specialRequestEnabled {
            Toggle(isOn: $order.cupcakeOrder.extraFrosting) {
              Text("Add extra frosting")
            }
            Toggle(isOn: $order.cupcakeOrder.addSprinkles) {
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
