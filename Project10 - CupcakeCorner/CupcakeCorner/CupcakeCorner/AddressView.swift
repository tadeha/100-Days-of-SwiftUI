//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Tadeh Alexani on 5/11/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct AddressView: View {
  
  @ObservedObject var order: Order
  
  var body: some View {
    Form {
      Section {
        TextField("Name", text: $order.cupcakeOrder.name)
        TextField("Streed Address", text: $order.cupcakeOrder.streetAddress)
        TextField("City", text: $order.cupcakeOrder.city)
        TextField("Zipcode", text: $order.cupcakeOrder.zip)
      }
      
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Checkout")
        }
      }
      .disabled(order.cupcakeOrder.hasValidAddress == false)
    }
    .navigationBarTitle("Delivery Details", displayMode: .inline)
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(order: Order())
  }
}
