//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/22/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  
  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[.originalImage] as? UIImage {
        self.parent.image = image
      }
      self.parent.presentationMode.wrappedValue.dismiss()
    }
  }
  
  @Binding var image: UIImage?
  @Environment(\.presentationMode) var presentationMode
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
  
}
