//
//  GameScene.swift
//  Chase Game
//
//  Created by 王元 on 16/6/7.
//  Copyright (c) 2016年 programus. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var gameManager:GameManager!
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.gameManager = GameManager(main: self)
    self.physicsWorld.contactDelegate = self
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
    if let touch = touches.first {
      gameManager.touchDownAt(touch.locationInNode(self))
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    gameManager.update(currentTime)
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    if GameHelpers.didCollideWith(contact: contact, collideA: GameHelpers.Character.Hero.rawValue, collideB: GameHelpers.Character.Diamond.rawValue) {
      if let diamond = GameHelpers.getNodeWith(contact: contact, nodeName: "d") as? Diamond {
        gameManager.heroHitDiamond(diamond)
      }
    }
    
    if GameHelpers.didCollideWith(contact: contact, collideA: GameHelpers.Character.Wall.rawValue, collideB: GameHelpers.Character.Hero.rawValue) {
      if let hero = GameHelpers.getNodeWith(contact: contact, nodeName: "h") as? Hero {
        hero.cancelMove()
      }
    }
  }
}
