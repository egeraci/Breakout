//
//  GameScene.swift
//  Breakout
//
//  Created by Student on 4/1/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        createBackground()
        
    }
    
    func createBackground()
    {
        let stars = SKTexture(imageNamed: "Stars")
        for i in 0...1
        {
            let starsbackground = SKSpriteNode (texture: stars)
            starsbackground.zPosition = -1
            starsbackground.position = CGPoint(x: 0, y: starsbackground.size.height * CGFloat(i))
            addChild(starsbackground)
            let moveDown = SKAction.moveBy(x: 0, y: -starsbackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsbackground.size.height, duration: 0)
            let moveloup = SKAction.sequence([moveDown, moveReset])
            let moveforever = SKAction .repeatForever(moveloup)
            starsbackground.run(moveforever)
        }
    }
}

