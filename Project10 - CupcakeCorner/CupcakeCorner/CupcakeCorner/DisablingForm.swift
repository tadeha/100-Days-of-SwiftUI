//
//  DisablingForm.swift
//  CupcakeCorner
//
//  Created by Tadeh Alexani on 5/10/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct DisablingForm: View {
  
  @State private var username = ""
  @State private var email = ""
  
  var disableForm: Bool {
    username.count < 5 || email.count < 5
  }
  
  var body: some View {
    Form {
      Section {
        TextField("Username", text: $username)
        TextField("Email", text: $email)
      }
      
      Section {
        Button("Create account") {
          print("Creating account…")
        }
      }
    .disabled(disableForm)
      
    }
  }
}

struct DisablingForm_Previews: PreviewProvider {
  static var previews: some View {
    DisablingForm()
  }
}
