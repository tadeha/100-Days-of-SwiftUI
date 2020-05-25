//
//  FileManager+Extension.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

extension FileManager {
  
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func save(_ str: String, withName name: String) {
    let url = self.getDocumentsDirectory().appendingPathComponent(name)

    do {
        try str.write(to: url, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
    }
  }
  
  func load(withName name: String) -> String? {
    let url = self.getDocumentsDirectory().appendingPathComponent(name)
    
    return try? String(contentsOf: url)
  }
  
}
