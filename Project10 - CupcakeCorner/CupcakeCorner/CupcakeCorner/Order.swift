//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tadeh Alexani on 5/11/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

class Order: ObservableObject {
  
  enum CodingKeys: CodingKey {
    case cupcakeOrder
  }
  
  @Published var cupcakeOrder: CupcakeOrder
  
  init() {
    self.cupcakeOrder = CupcakeOrder()
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    cupcakeOrder = try container.decode(CupcakeOrder.self, forKey: .cupcakeOrder)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(cupcakeOrder, forKey: .cupcakeOrder)
  }
  
  
}

struct CupcakeOrder: Codable {
  
  static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
  
  var type = 0
  var quantity = 3
  
  var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  var extraFrosting = false
  var addSprinkles = false
  
  var name = ""
  var streetAddress = ""
  var city = ""
  var zip = ""
  
  var hasValidAddress: Bool {
    if name.isEmptyOrWhitespace() || streetAddress.isEmptyOrWhitespace() || city.isEmptyOrWhitespace() || zip.isEmptyOrWhitespace() {
      return false
    }
    return true
  }
  
  var cost: Double {
    var cost = Double(quantity) * 2
    
    cost += (Double(type) / 2)
    
    if extraFrosting {
      cost += Double(quantity)
    }
    
    if addSprinkles {
      cost += Double(quantity) / 2
    }
    
    return cost
  }
}

extension String {
  func isEmptyOrWhitespace() -> Bool {
    if(self.isEmpty) {
      return true
    }
    return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
  }
}
