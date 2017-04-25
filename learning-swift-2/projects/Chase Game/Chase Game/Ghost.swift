//
//  Ghost.swift
//  Chase Game
//
//  Created by Programus on 16/6/12.
//  Copyright © 2016年 programus. All rights reserved.
//

import Foundation
import SpriteKit

public class Ghost:SKSpriteNode {
  var lastUpdate = CFTimeInterval()
  var moveInterval = 0.1
  
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
    self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = GameHelpers.Character.Ghost.rawValue
    self.physicsBody?.collisionBitMask = GameHelpers.Character.Wall.rawValue
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func moveToHero(position:CGPoint) {
    removeAllActions()
    runAction(SKAction.moveTo(position, duration: 1.5))
  }
  
  public func update(currentTime:CFTimeInterval, heroPosition:CGPoint) {
    let now = NSDate.timeIntervalSinceReferenceDate()
    let sinceLast = now - lastUpdate
    if sinceLast > moveInterval {
      lastUpdate = now
      moveToHero(heroPosition)
    }
  }
}