//
//  GameScene.swift
//  Breakout
//
//  Created by Student on 4/1/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   var ball = SKShapeNode ()
    var pattel = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        createBackground()
        restGame()
        
    }
    
    func restGame()
    {
        //this stuff happens before each game starts
        makeball()
        makepattle()
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
    func makeball()
    {
        ball.removeFromParent() //remove ball if it exists
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .yellow
        ball.name = "ball"
        
        //physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        //ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        //use precise collision detection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        //no loss of energy from friction
        ball.physicsBody?.friction = 0
        //gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        //bounces fully off other objects
        ball.physicsBody?.restitution = 1
        //does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball) //add ball object to view
    }
    
    func makepattle()
    {
        pattel.removeFromParent()
        pattel = SKSpriteNode(color: .white, size:CGSize(width: frame.width/4, height: 20))
        pattel.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        pattel.name = "pattel"
        pattel.physicsBody = SKPhysicsBody(rectangleOf: pattel.size)
        pattel.physicsBody?.isDynamic = false
        addChild(pattel)
    }
}

