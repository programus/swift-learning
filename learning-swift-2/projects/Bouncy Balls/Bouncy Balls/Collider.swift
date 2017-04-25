//
//  Collider.swift
//  Bouncy Balls
//
//  Created by Programus on 16/6/19.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation

struct Collider {
  static let HERO:UInt32 = 1 << 1
  static let BALL:UInt32 = 1 << 2
  static let CAGE:UInt32 = 1 << 3
}