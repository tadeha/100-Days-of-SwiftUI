//
//  MeView.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/9/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
  
  @State private var name = "Anonymous"
  @State private var emailAddress = "you@yoursite.com"
  
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Your Name", text: $name)
          .font(.title)
          .textContentType(.name)
          .padding([.horizontal])
        
        TextField("Your Email Address", text: $emailAddress)
          .font(.title)
          .textContentType(.emailAddress)
          .padding([.horizontal, .bottom])
        
        Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
          .interpolation(.none)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
        
        Spacer()
        
      }
      .navigationBarTitle("Your Code")
    }
  }
  
  func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")
    
    if let outputImage = filter.outputImage {
      if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImage)
      }
    }
    
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
}

struct MeView_Previews: PreviewProvider {
  static var previews: some View {
    MeView()
  }
}
