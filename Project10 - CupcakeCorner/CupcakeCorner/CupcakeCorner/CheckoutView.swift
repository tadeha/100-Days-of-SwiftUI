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
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  
  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical) {
        VStack(alignment: .center, spacing: 30) {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
          
          Text("Your total is $\(self.order.cupcakeOrder.cost, specifier: "%.2f")")
            .font(.title)
            .fontWeight(.bold)
          
          Button("Place Order") {
            self.placeOrder()
          }
          .frame(width: geo.size.width * 0.5, height: 44)
          .background(Color.green)
          .foregroundColor(.white)
          .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal])
      }
      .navigationBarTitle("Check out", displayMode: .inline)
      .alert(isPresented: self.$showingAlert) {
        Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
      }
    }
  }
  
  func placeOrder() {
    
    guard let encoded = try? JSONEncoder().encode(order.cupcakeOrder) else {
      print("Failed to encode order")
      return
    }
    
    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encoded
    
    URLSession.shared.dataTask(with: request) {
      data, response, error in
      guard let data = data else {
        self.alertTitle = "Error Occured"
        self.alertMessage = error?.localizedDescription ?? "Unknown Error"
        self.showingAlert = true
        return
      }
      if let decodedOrder = try? JSONDecoder().decode(CupcakeOrder.self, from: data) {
        self.alertTitle = "Thank you"
        self.alertMessage = "Your order for \(decodedOrder.quantity)x \(CupcakeOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        self.showingAlert = true
      } else {
        self.alertTitle = "Error Occured"
        self.alertMessage = "Invalid response from server"
        self.showingAlert = true
      }
      
    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
