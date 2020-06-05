//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/24/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
  var successHandler: (() -> Void)?
  var errorHandler: ((Error) -> Void)?
  
  func writeToPhotoAlbum(image: UIImage) {
    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: yourURL, options: [.atomicWrite, .completeFileProtection])
    }
  }
  @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      errorHandler?(error)
    } else {
      successHandler?()
    }
  }
}
