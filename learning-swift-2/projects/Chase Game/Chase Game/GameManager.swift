//
//  GameManager.swift
//  Chase Game
//
//  Created by Programus on 16/6/12.
//  Copyright © 2016年 programus. All rights reserved.
//

import Foundation
import SpriteKit

var tileSize = CGSize(width: 70, height: 70)
var tileAtlas = SKTextureAtlas(named: "tiles")
var ghosts = [Ghost]()
var diamonds = [Diamond]()
var hero:Hero!

public class GameManager {
  var currentLevel = 0
  var maxLevel = 0
  var levels:[[String]]
  var tiles = [SKSpriteNode]()
  var main:SKScene
  
  init(main:SKScene) {
    self.main = main
    self.levels = NSBundle.mainBundle().objectForInfoDictionaryKey("Levels") as! [[String]]
    self.loadLevelData()
    self.load(levelNumber: self.currentLevel)
  }
  
  private func loadLevelData() {
    self.maxLevel = levels.count
  }
  
  private func load(levelNumber levelIndex:Int) {
    self.main.removeAllChildren()
    
    let level = self.levels[levelIndex]
    
    var reuseTile:SKSpriteNode!
    var start = CGPoint(x: 0, y: 0)
    
    start.x = (CGFloat(level[0].characters.count - 1) * tileSize.width) / -2.0
    start.y = (CGFloat(level.count - 1) * tileSize.height) / -2.0
    
    for (row, line) in level.enumerate() {
      for (col, tile) in Array(line.characters).enumerate() {
        let thisTile = String(tile)
        let texture = tileAtlas.textureNamed("tile_\(thisTile)")
        switch thisTile {
        case "8":
          reuseTile = Tile(texture: texture, color: SKColor.clearColor(), size: texture.size())
          tiles.append(reuseTile as! Tile)
        case "h":
          reuseTile = Hero(texture: texture, color: SKColor.clearColor(), size: texture.size())
          hero = reuseTile as! Hero
        case "b":
          reuseTile = Ghost(texture: texture, color: SKColor.clearColor(), size: texture.size())
          ghosts.append(reuseTile as! Ghost)
        case "d":
          reuseTile = Diamond(texture: texture, color: SKColor.clearColor(), size: texture.size())
          diamonds.append(reuseTile as! Diamond)
        default:
          continue
        }
        
        reuseTile.position.x = start.x + CGFloat(col) * tileSize.width
        reuseTile.position.y = start.y + CGFloat(row) * tileSize.height
        
        reuseTile.name = thisTile
        tiles.append(reuseTile)
        self.main.addChild(reuseTile)
      }
    }
  }
  
  private func updateGhosts(currentTime:CFTimeInterval) {
    for ghost in ghosts {
      ghost.update(currentTime, heroPosition: hero.position)
    }
  }
  
  public func touchDownAt(location:CGPoint) {
    hero.moveTo(location)
  }
  
  public func heroHitDiamond(diamond:Diamond) {
    diamond.removeFromParent()
    diamonds.removeAtIndex(diamonds.indexOf(diamond)!)
    if diamonds.count == 0 {
      print("win level!")
    }
  }
  
  public func update(currentTime:CFTimeInterval) {
    updateGhosts(currentTime)
  }
}