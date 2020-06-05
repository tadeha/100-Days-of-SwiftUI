//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Tadeh Alexani on 5/24/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import UIKit

class CodableImageSaver {
  func saveData(codableImages: [CodableImage]) {
    do {
      let filename = FileManager.getDocumentsDirectory().appendingPathComponent("SavedPhotos")
      let data = try JSONEncoder().encode(codableImages)
      try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data.")
    }
  }
  
}
