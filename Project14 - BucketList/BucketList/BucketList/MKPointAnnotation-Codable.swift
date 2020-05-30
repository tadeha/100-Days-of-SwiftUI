//
//  MKPointAnnotation-Codable.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/29/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import MapKit

class CodableMKPointAnnotaiton: MKPointAnnotation, Codable {
  
  enum CodingKeys: CodingKey {
    case title, subtitle, latitude, longitude
  }
  
  override init() {
    super.init()
  }
  
  required init(from decoder: Decoder) throws {
    super.init()
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    subtitle = try container.decode(String.self, forKey: .subtitle)
    
    let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
    let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
    coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(title, forKey: .title)
    try container.encode(subtitle, forKey: .subtitle)
    try container.encode(coordinate.latitude, forKey: .latitude)
    try container.encode(coordinate.longitude, forKey: .longitude)
  }
  
}
