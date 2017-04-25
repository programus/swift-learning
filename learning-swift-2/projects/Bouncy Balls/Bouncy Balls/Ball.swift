//
//  Ball.swift
//  Bouncy Balls
//
//  Created by Programus on 16/6/19.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation
import SpriteKit

public class Ball:SKSpriteNode {
  public var type = 0
  public var hit = false
  
  init(type:Int) {
    self.type = type
    let texture = SKTexture(imageNamed: "ball_\(type)")
    super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    physicsBody = SKPhysicsBody(circleOfRadius: texture.size().width / 2)
    physicsBody?.dynamic = false
    physicsBody?.categoryBitMask = Collider.BALL
    physicsBody?.collisionBitMask = Collider.HERO
    physicsBody?.contactTestBitMask = Collider.HERO
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}