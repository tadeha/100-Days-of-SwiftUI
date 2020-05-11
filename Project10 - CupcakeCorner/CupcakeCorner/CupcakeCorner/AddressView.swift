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
        TextField("Name", text: $order.name)
        TextField("Streed Address", text: $order.streetAddress)
        TextField("City", text: $order.city)
        TextField("Zipcode", text: $order.zip)
      }
      
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Checkout")
        }
      }
      .disabled(order.hasValidAddress == false)
    }
    .navigationBarTitle("Delivery Details", displayMode: .inline)
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(order: Order())
  }
}
