//
//  AddView.swift
//  CatchUp
//
//  Created by Tadeh Alexani on 6/4/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AddView: View {
  @State private var image: Image?
  @State private var inputImage: UIImage?
  @State private var showingSheet = false
  @State private var imageChosen = false
  @State private var chosenName = ""
  
  @State private var showingAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  
  @Environment(\.presentationMode) var presentationMode
    
  @State var images = [CodableImage]()
  
  let locationFetcher = LocationFetcher()
  
  var body: some View {
    VStack {
      
      if imageChosen {
        
        image?
          .resizable()
          .scaledToFit()
        
        TextField("Name the Photo", text: $chosenName)
          .padding()
        
        Button("Save") {
          if self.chosenName == "" {
            self.alertTitle = "Empty Name Error"
            self.alertMessage = "Please enter a name for your image."
            self.showingAlert = true
          } else {
            guard let inputImage = self.inputImage, let jpegData = inputImage.jpegData(compressionQuality: 0.8) else {
              self.presentationMode.wrappedValue.dismiss()
              return
            }
            
            if let location = self.locationFetcher.lastKnownLocation {
                
              let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
              
              print(location)
              
              let codableImage = CodableImage(jpegData: jpegData, name: self.chosenName, coordinate: coordinate)
              
              self.images.append(codableImage)
              
              let imageSaver = CodableImageSaver()
              imageSaver.saveData(codableImages: self.images)
              
              self.presentationMode.wrappedValue.dismiss()
              
            } else {
              self.alertTitle = "Empty Fetching Location"
              self.alertMessage = "Your location is unknown"
              self.showingAlert = true
            }
            
            
          }
        }
        .padding()
        .background(Color.green)
        .foregroundColor(.white)
        .clipShape(Capsule())
        
      } else {
        Button("Select Image") {
          self.showingSheet = true
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
      }
      
    }
    .navigationBarTitle("Add Image")
    .navigationBarItems(trailing: Button("Close") {
      self.presentationMode.wrappedValue.dismiss()
    })
      .sheet(isPresented: $showingSheet, onDismiss: loadImage) {
        ImagePicker(image: self.$inputImage)
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
    }
    .onAppear(perform: startFetchingLocation)
  
  }
  
  func startFetchingLocation() {
    locationFetcher.start()
  }
  
  func loadImage() {
    guard let inputImage = inputImage else {
      return
    }
    image = Image(uiImage: inputImage)
    
    imageChosen = true
  }
  
}
