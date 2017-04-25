//
//  Hero.swift
//  Chase Game
//
//  Created by Programus on 16/6/12.
//  Copyright © 2016年 programus. All rights reserved.
//

import Foundation
import SpriteKit

public class Hero:SKSpriteNode {
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = GameHelpers.Character.Hero.rawValue
    self.physicsBody?.collisionBitMask =
      GameHelpers.Character.Diamond.rawValue |
      GameHelpers.Character.Ghost.rawValue |
      GameHelpers.Character.Wall.rawValue
    self.physicsBody?.contactTestBitMask =
      GameHelpers.Character.Ghost.rawValue |
      GameHelpers.Character.Diamond.rawValue
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func moveTo(location:CGPoint) {
    removeAllActions()
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, position.x, position.y)
    CGPathAddLineToPoint(path, nil, location.x, location.y)
    runAction(SKAction.followPath(path, asOffset: false, orientToPath: false, speed: 500))
  }
  
  public func cancelMove() {
    removeAllActions()
  }
}