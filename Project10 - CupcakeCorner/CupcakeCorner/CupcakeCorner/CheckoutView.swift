//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tadeh Alexani on 5/11/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
  
  @ObservedObject var order: Order
  
  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical) {
        VStack(alignment: .center, spacing: 30) {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
          
          Text("Your total is $\(self.order.cost, specifier: "%.2f")")
            .font(.title)
            .fontWeight(.bold)
          
          Button("Place Order") {
            // place the order
          }
          .frame(width: geo.size.width * 0.5, height: 44)
          .background(Color.green)
          .foregroundColor(.white)
          .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal])
      }
    }
    .navigationBarTitle("Check out", displayMode: .inline)
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
