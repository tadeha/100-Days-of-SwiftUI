//
//  ContentView_Day64.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/21/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

class ImageSaver: NSObject {
  func writeToPhotoAlbum(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
  }
  
  @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    print("Save finished!")
  }
}

struct ContentView_Day64: View {
  
  @State private var image: Image?
  @State private var showingSheet = false
  @State private var inputImage: UIImage?
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
      
      Button("Select Image") {
        self.showingSheet = true
      }
    }
    .sheet(isPresented: $showingSheet, onDismiss: loadImage) {
      ImagePicker(image: self.$inputImage)
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else {
      return
    }
    image = Image(uiImage: inputImage)
    
    let imageSaver = ImageSaver()
    imageSaver.writeToPhotoAlbum(image: inputImage)

  }
  
}
