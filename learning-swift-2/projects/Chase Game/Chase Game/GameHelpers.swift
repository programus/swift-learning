//
//  GameHelpers.swift
//  Chase Game
//
//  Created by Programus on 16/6/12.
//  Copyright © 2016年 programus. All rights reserved.
//

import Foundation
import SpriteKit

class GameHelpers {
  enum Character:UInt32 {
    case Hero     = 0b0001
    case Ghost    = 0b0010
    case Diamond  = 0b0100
    case Wall     = 0b1000
  }
  
  class func didCollideWith(contact contact:SKPhysicsContact, collideA:UInt32, collideB:UInt32) -> Bool {
    let bitMaskA = contact.bodyA.categoryBitMask
    let bitMaskB = contact.bodyB.categoryBitMask
    
    let aa = bitMaskA & collideA != 0
    let bb = bitMaskB & collideB != 0
    let ab = bitMaskA & collideB != 0
    let ba = bitMaskB & collideA != 0
    
    return (aa && bb) || (ab && ba)
  }
  
  class func getNodeWith(body body:SKPhysicsBody, nodeName:String) -> SKNode? {
    if let name = body.node?.name {
      if name == nodeName {
        return body.node
      }
    }
    
    return nil
  }
  
  class func getNodeWith(contact contact:SKPhysicsContact, nodeName:String) -> SKNode? {
    if let node = getNodeWith(body: contact.bodyA, nodeName: nodeName) {
      return node
    } else if let node = getNodeWith(body: contact.bodyB, nodeName: nodeName) {
      return node
    } else {
      return nil
    }
  }
}