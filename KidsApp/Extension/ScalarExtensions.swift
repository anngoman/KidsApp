//
//  ScalarExtensions.swift
//  KidsApp
//
//  Created by Anna Goman on 02.09.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import UIKit

extension Int {
  var degreesToRadians : Float {
    let cgFloat = CGFloat(self) * CGFloat(M_PI) / 180.0
    return Float(cgFloat)
  }
}