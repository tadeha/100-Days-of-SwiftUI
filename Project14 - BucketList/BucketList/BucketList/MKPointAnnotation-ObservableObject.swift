//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/29/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
  public var wrappedTitle: String {
    get {
      self.title ?? "Unknown Value"
    }
    set {
      title = newValue
    }
  }
  public var wrappedDescription: String {
    get {
      self.subtitle ?? "Unknown Value"
    }
    set {
      subtitle = newValue
    }
  }
}
