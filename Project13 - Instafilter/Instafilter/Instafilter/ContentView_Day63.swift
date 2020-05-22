//
//  ContentView_Day63.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/21/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView_Day63: View {
  
  @State private var image: Image?
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
  .onAppear(perform: loadImage)
  }
  
  func loadImage() {
    guard let inputImg = UIImage(named: "example") else {
      return
    }
    let beginImg = CIImage(image: inputImg)
    
    let context = CIContext()
    let currentFilter = CIFilter.sepiaTone()
    
    currentFilter.inputImage = beginImg
    currentFilter.intensity = 1
    
    guard let outputImg = currentFilter.outputImage else {
      return
    }
    
    if let cgimg = context.createCGImage(outputImg, from: outputImg.extent) {
      let uiImg = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImg)
    }
    
  }
}
