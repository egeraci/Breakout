//
//  GameScene.swift
//  Breakout
//
//  Created by Student on 4/1/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var ball = SKShapeNode ()
    var pattel = SKSpriteNode()
    var brick = SKSpriteNode()
    var losezone = SKSpriteNode()
    var playlabel = SKLabelNode()
    var  liveslabel = SKLabelNode()
    var scorelabel = SKLabelNode()
    var plangame = false
    var score = 0
    var lives = 3
    
    override func didMove(to view: SKView)
    {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createBackground()
        restGame()
        makelosezone()
        makeLabels()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "brick" || contact.bodyB.node?.name == "brick"
        {
            print("YOU WIN!")
            brick.removeFromParent()
            ball.removeFromParent()
        }
        if contact.bodyA.node?.name == "lose zone" || contact.bodyB.node?.name == "lose zone"
        {
            print("you lose, better luck next time.")
            ball.removeFromParent()
        }
    }
    
    func restGame()
    {
        //this stuff happens before each game starts
        makeball()
        makepattle()
        makebrick()
        updateLabels()
    }
    
    func kickball()
    {
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 5))
    }
   func updateLabels()
    {
        scorelabel.text = "score: \(score)"
        liveslabel.text = "lives:\(lives)"
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
    
    func makebrick()
    {
        brick.removeFromParent()
        brick = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
        brick.position = CGPoint(x: frame.midX, y: frame.maxY-50)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makelosezone()
    {
        losezone = SKSpriteNode(color: .red, size: CGSize(width: frame.width, height: 50))
        losezone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
        losezone.name = "lose zone"
        losezone.physicsBody = SKPhysicsBody(rectangleOf: losezone.size)
        losezone.physicsBody?.isDynamic = false
        addChild(losezone)
    }
    
    func makeLabels()
    {
        playlabel.fontSize = 20
        playlabel.text = "tap to start"
        playlabel.fontName = "Arial"
        playlabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        playlabel.name = "play label"
        addChild(playlabel)
        
        liveslabel.fontSize = 18
        liveslabel.fontColor = .black
        liveslabel.position = CGPoint(x: frame.minX + 50, y: frame.minY + 18)
        addChild(liveslabel)
        
        scorelabel.fontSize = 18
        scorelabel.fontColor = .black
        scorelabel.fontName = "Arial"
        scorelabel.position = CGPoint(x: frame.maxX - 50, y: frame.minY + 18)
        addChild(scorelabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if plangame
            {
                pattel.position.x = location.x
            }
            else
            {
                for node in nodes(at: location)
                {
                    if node.name == "play label"
                    {
                        plangame = true
                        node.alpha = 0
                        score = 0
                        lives = 3
                        updateLabels()
                        kickball()
                    }
                }
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            pattel.position.x = location.x
        }
    }
}

