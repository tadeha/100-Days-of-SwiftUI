//
//  CodableImage.swift
//  CatchUp
//
//  Created by Tadeh Alexani on 6/4/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import CoreLocation

class CodableImage: Codable, Comparable {
  
  var id = UUID()
  let jpegData: Data
  let name: String
  let coordinate: CLLocationCoordinate2D
  
  enum CodingKeys: CodingKey {
    case id, jpegData, name, latitude, longitude
  }

  init(jpegData: Data, name: String, coordinate: CLLocationCoordinate2D) {
    self.jpegData = jpegData
    self.name = name
    self.coordinate = coordinate
  }
  
  public required init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(UUID.self, forKey: .id)
    jpegData = try container.decode(Data.self, forKey: .jpegData)
    name = try container.decode(String.self, forKey: .name)
    let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
    let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
    coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(jpegData, forKey: .jpegData)
    try container.encode(name, forKey: .name)
    try container.encode(coordinate.latitude, forKey: .latitude)
    try container.encode(coordinate.longitude, forKey: .longitude)
  }
  
  static func < (lhs: CodableImage, rhs: CodableImage) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: CodableImage, rhs: CodableImage) -> Bool {
    lhs.name == rhs.name
  }
}
