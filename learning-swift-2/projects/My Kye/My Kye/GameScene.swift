//
//  GameScene.swift
//  My Kye
//
//  Created by 王元 on 16/5/15.
//  Copyright (c) 2016年 programus. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    let xy = 0.5
    self.anchorPoint = CGPoint(x: xy, y: xy)
    let background = SKSpriteNode(imageNamed: "bg")
    self.addChild(background)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
    
    for touch in touches {
      let location = touch.locationInNode(self)
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}
