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

enum FilterNames: String {
  case crystalize = "Crystallize"
  case edges = "Edges"
  case gaussianBlur = "Gaussian Blur"
  case pixellate = "Pixellate"
  case sepiaTone = "Sepia Tone"
  case unsharpMask = "Unsharp Mask"
  case vignette = "Vignette"
}

struct ContentView: View {
  
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false
  @State private var showingFilterSheet = false
  @State private var inputImage: UIImage?
  @State private var proccessedImage: UIImage?
  @State var currentFilter: CIFilter = CIFilter.sepiaTone()
  let context = CIContext()
  
  @State private var showingAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  
  @State private var currentFilterName = "Change Filter"
  
  @State private var sliderText = "Intensity"
  
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
          Text(sliderText)
          Slider(value: intensity)
        }
        .padding(.vertical)
        HStack {
          Button(currentFilterName) {
            self.showingFilterSheet = true
          }
          Spacer()
          Button("Save") {
            guard let proccessedImage = self.proccessedImage else {
              self.alertTitle = "Error Saving"
              self.alertMessage = "Please select a photo first."
              self.showingAlert = true
              return
            }
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
              print("Success!")
            }
            
            imageSaver.errorHandler = {
              print("Oops: \($0.localizedDescription)")
            }
            
            imageSaver.writeToPhotoAlbum(image: proccessedImage)
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationBarTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: self.$inputImage)
      }
      .actionSheet(isPresented: $showingFilterSheet) {
        ActionSheet(title: Text("Select a filter"), buttons: [
          .default(Text(FilterNames.crystalize.rawValue)) {
            self.currentFilterName = FilterNames.crystalize.rawValue
            self.setFilter(CIFilter.crystallize())
          },
          .default(Text(FilterNames.edges.rawValue)) {
            self.currentFilterName = FilterNames.edges.rawValue
            self.setFilter(CIFilter.edges())
          },
          .default(Text(FilterNames.gaussianBlur.rawValue)) {
            self.currentFilterName = FilterNames.gaussianBlur.rawValue
            self.setFilter(CIFilter.gaussianBlur())
          },
          .default(Text(FilterNames.pixellate.rawValue)) {
            self.currentFilterName = FilterNames.pixellate.rawValue
            self.setFilter(CIFilter.pixellate())
          },
          .default(Text(FilterNames.sepiaTone.rawValue)) {
            self.currentFilterName = FilterNames.sepiaTone.rawValue
            self.setFilter(CIFilter.sepiaTone())
          },
          .default(Text(FilterNames.unsharpMask.rawValue)) {
            self.currentFilterName = FilterNames.unsharpMask.rawValue
            self.setFilter(CIFilter.unsharpMask())
          },
          .default(Text(FilterNames.vignette.rawValue)) {
            self.currentFilterName = FilterNames.vignette.rawValue
            self.setFilter(CIFilter.vignette())
          },
          .cancel()
        ])
      }
        
      .alert(isPresented: $showingAlert) {
        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
      }
    }
  }
  
  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    
    if currentFilter.name == "CISepiaTone" {
      currentFilterName = FilterNames.sepiaTone.rawValue
    }
    
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) {
      sliderText = "Intensity"
      currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
    }
    if inputKeys.contains(kCIInputRadiusKey) {
      sliderText = "Radius"
      currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
    }
    if inputKeys.contains(kCIInputScaleKey) {
      sliderText = "Scale"
      currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
    }
    
    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
      proccessedImage = uiImage
    }
  }
  
}
