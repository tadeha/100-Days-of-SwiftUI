//
//  ArrowShape.swift
//  Drawing
//
//  Created by Tadeh Alexani on 5/4/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import UIKit
import SwiftUI

struct Arrow: Shape {
  var height: CGFloat = 1 / 8
  var width: CGFloat = 1 / 4
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.maxX * width, y: rect.maxY))
    
    path.addLine(to: CGPoint(x: rect.maxX * width * 3, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX * width * 3, y: rect.maxY * height * 5))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * height * 5))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * height * 5))
    path.addLine(to: CGPoint(x: rect.maxX * width, y: rect.maxY * height * 5))
    path.addLine(to: CGPoint(x: rect.maxX * width, y: rect.maxY))
    
    
    return path
  }
}
