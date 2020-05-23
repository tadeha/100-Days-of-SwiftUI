//
//  ContentView.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/21/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
  
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  
  @State var currentFilter = CIFilter.sepiaTone()
  let context = CIContext()
  
  var body: some View {
    let intensity = Binding<Double>(
      get: {
        self.filterIntensity
    },
      set: {
        self.filterIntensity = $0
        self.applyProcessing()
    }
    )
    
    return NavigationView {
      VStack {
        ZStack {
          
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.secondary)
          
          if image != nil {
            image?
              .resizable()
              .scaledToFit()
          } else {
            VStack {
              Image(systemName: "plus.circle")
                .font(.largeTitle)
                .foregroundColor(.white)
              Text("Please select an image")
                .font(.headline)
                .foregroundColor(.white)
            }
            
          }
        }
        .onTapGesture {
          self.showingImagePicker = true
        }
        HStack {
          Text("Intensity")
          Slider(value: intensity)
        }
        .padding(.vertical)
        HStack {
          Button("Change Filter") {
            
          }
          Spacer()
          Button("Save") {
            
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationBarTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: self.$inputImage)
      }
      
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func applyProcessing() {
    currentFilter.intensity = Float(filterIntensity)
    
    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
    }
  }
  
}
