//
//  FileManager+Extension.swift
//  CatchUp
//
//  Created by Tadeh Alexani on 6/4/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import Foundation

extension FileManager {
  static func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}
