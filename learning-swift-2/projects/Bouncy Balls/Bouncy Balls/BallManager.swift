//
//  BallManager.swift
//  Bouncy Balls
//
//  Created by Programus on 16/6/19.
//  Copyright © 2016 programus. All rights reserved.
//

import Foundation
import SpriteKit

public class BallManager {
  public var balls = [Ball]()
  private var levels = [[String]]()
  private var mainBall:SKSpriteNode!
  public var currentLevel = 0

  init() {
    levels = NSBundle.mainBundle().objectForInfoDictionaryKey("Levels") as! [[String]]
  }
  
  public func loadLevel(scene:SKScene) {
    if levels.count == currentLevel {
      print("You win the game.")
      return
    }
    
    let spaceBetween:CGFloat = 1.5
    
    let ballsPerRow = levels[0][0].characters.split(",").map(String.init).count
    let tempBall = Ball(type: 1)
    let ballsWidth = CGFloat(ballsPerRow) * (tempBall.size.width * spaceBetween)
    let toCenterPaddingX = ((scene.size.width - ballsWidth) / 2) + tempBall.size.width
    
    let ballsHeight = CGFloat(levels[currentLevel].count) * (tempBall.size.height * spaceBetween)
    let toCenterPaddingY = ((scene.size.height - ballsHeight) / 2) + tempBall.size.height
    
    for (i, row) in levels[currentLevel].enumerate() {
      let ballList = row.characters.split(",").map(String.init)
      for (j, ball) in ballList.enumerate() {
        let ballSprite = Ball(type: 1)
        if ball == "0" {
          continue
        }
        if ball != "1" {
          ballSprite.runAction(SKAction.setTexture(SKTexture(imageNamed: "ball_\(ball)")))
        }
        ballSprite.position = CGPoint(x: toCenterPaddingX + (CGFloat(j) * ballSprite.size.width * spaceBetween),
                                      y: toCenterPaddingY + (CGFloat(i) * ballSprite.size.height * spaceBetween))
        balls.append(ballSprite)
      }
    }
  }
  
  public func addLevelTo(scene:SKNode) {
    for ball in balls {
      scene.addChild(ball)
    }
  }
  
  public func dropMainBall(onScene scene:SKScene, atLocation:CGPoint) {
    if mainBall != nil {
      return
    }
    
    mainBall = SKSpriteNode(imageNamed: "ball_main")
    mainBall.physicsBody = SKPhysicsBody(circleOfRadius: mainBall.size.width / 2)
    mainBall.position = atLocation
    mainBall.physicsBody?.restitution = 1
    mainBall.physicsBody?.angularVelocity = 0.1
    mainBall.physicsBody?.categoryBitMask = Collider.HERO
    mainBall.physicsBody?.collisionBitMask = Collider.BALL | Collider.CAGE
    mainBall.physicsBody?.contactTestBitMask = Collider.BALL | Collider.CAGE
    scene.addChild(mainBall)
  }
  
  public func ballHit(ball:Ball) {
    if ball.hit {
      return
    }
    
    ball.hit = true
    ball.runAction(SKAction.fadeAlphaTo(0.1, duration: 0.3))
  }
  
  public func removeHitBalls(removeMainBall:Bool = true) {
    for (i, ball) in balls.enumerate().reverse() {
      if ball.hit {
        ball.hit = false
        ball.removeFromParent()
        balls.removeAtIndex(i)
      }
    }
    
    if mainBall != nil && removeMainBall {
      mainBall.removeFromParent()
      mainBall = nil
    }
  }
  
  public func isGameOver() -> Bool {
    return balls.count == 0
  }
  
  public func update() {
    if mainBall != nil && mainBall.physicsBody!.resting {
      removeHitBalls()
    }
  }
}