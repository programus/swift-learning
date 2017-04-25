//
//  GameScene.swift
//  Bouncy Balls
//
//  Created by 王元 on 16/6/18.
//  Copyright (c) 2016年 programus. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  let ballManager = BallManager()
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    physicsWorld.contactDelegate = self
    backgroundColor = SKColor.grayColor()
    addCage()
    ballManager.loadLevel(self)
    ballManager.addLevelTo(self)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
    if let touch = touches.first {
      ballManager.dropMainBall(onScene: self, atLocation: CGPoint(x: touch.locationInNode(self).x, y: CGRectGetMaxY(frame) - 100))
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    ballManager.update()
  }
  
  func addCage() {
    let physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    self.physicsBody = physicsBody
    self.physicsBody?.categoryBitMask = Collider.CAGE
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    for body in [contact.bodyA, contact.bodyB] {
      if body.categoryBitMask == Collider.BALL {
        ballManager.ballHit(body.node as! Ball)
      }
    }
    if contact.bodyA.categoryBitMask == Collider.CAGE || contact.bodyB.categoryBitMask == Collider.CAGE {
      ballManager.removeHitBalls()
      if ballManager.isGameOver() {
        ballManager.currentLevel += 1
        ballManager.loadLevel(self)
        ballManager.addLevelTo(self)
      }
    }
  }
}
