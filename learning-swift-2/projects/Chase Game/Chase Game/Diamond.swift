//
//  Diamond.swift
//  Chase Game
//
//  Created by Programus on 16/6/12.
//  Copyright © 2016年 programus. All rights reserved.
//

import Foundation
import SpriteKit

public class Diamond:SKSpriteNode {
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
    self.physicsBody?.dynamic = false
    self.physicsBody?.categoryBitMask = GameHelpers.Character.Diamond.rawValue
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}