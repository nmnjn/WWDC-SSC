//
//  GameScene.swift
//  BookCore
//
//  Created by Naman Jain on 07/05/20.
//

import SpriteKit
import UIKit

public class GameScene: SKScene, SKPhysicsContactDelegate{
    
    // VIP VARIABLES
    var numberOfPeople = 2
    let numberOfHackers = 2
    var encrypted = false
    var message = "Hello World!"
    let maxPersonSpeed: UInt32 = 150
    
    var nina: SKSpriteNode!
    var jake: SKSpriteNode!
    var document: SKSpriteNode!
    var key: SKSpriteNode!
    var hackers = [SKSpriteNode]()
    var game = false
    var movingDocument = false
    
    var player: SKSpriteNode!
    var people = [SKSpriteNode]()
    var gameOver = false
    var movingPlayer = false
    var movingKey = false
    var offset: CGPoint!
    var documentMessage: SKLabelNode!
    var keyMessage: SKLabelNode!
    var movedDocument = false
    var didEncryptDocument = false
    
    func positionWithin(range: CGFloat, containerSize: CGFloat) -> CGFloat{
        let randomNum = CGFloat(arc4random_uniform(100)) / 100.0
        let newContainer = (containerSize * ( 1.0 - range) * 0.5)
        let calc = (containerSize * range + newContainer)
        return randomNum * calc
    }
    
    func distanceFrom(posA: CGPoint, posB: CGPoint) -> CGFloat {
        let aSquare = (posA.x - posB.x) * (posA.x - posB.x)
        let bSquare = (posA.y - posB.y) * (posA.y - posB.y)
        return sqrt(aSquare + bSquare)
    }
    
    
    public override func didMove(to view: SKView) {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        
        physicsWorld.contactDelegate = self
        
        player = SKSpriteNode(texture: SKTexture(image: UIImage(named: "White Santa Claus Emoji.png")!), color: .clear, size: CGSize(width: size.width*0.05, height: size.width*0.05))
        
        nina = SKSpriteNode(texture: SKTexture(image: UIImage(named: "Nina.png")!), color: .clear, size: CGSize(width: size.width*0.06, height: size.width*0.06))
        
        document = SKSpriteNode(texture: SKTexture(image: UIImage(named: "Document.png")!), color: .clear, size: CGSize(width: size.width*0.05, height: size.width*0.05))
        
        key = SKSpriteNode(texture: SKTexture(image: UIImage(named: "Key.png")!), color: .clear, size: CGSize(width: size.width*0.025, height: size.width*0.025))
        
        jake = SKSpriteNode(texture: SKTexture(image: UIImage(named: "Jake.png")!), color: .clear, size: CGSize(width: size.width*0.06, height: size.width*0.06))
        
        documentMessage = SKLabelNode(text: "Drag this document to Jake!")
        documentMessage.fontSize = 16
        documentMessage.position = CGPoint(x: 250, y: 80)
        documentMessage.fontName = "AvenirNext-Bold"
        documentMessage.zPosition = 3
        documentMessage.fontColor = UIColor.systemBlue.withAlphaComponent(0.5)
        //        encryptLabel.alpha = 0
        
        
        nina.position = CGPoint(x: 100, y: 100)
        document.position = CGPoint(x: 140, y: 140)
        jake.position = CGPoint(x: frame.width - 100, y: frame.height - 100)
        key.position = CGPoint(x: frame.width - 100, y: frame.height - 140)
        
        addChild(nina)
        addChild(jake)
        addChild(document)
        
        if encrypted{
            keyMessage = SKLabelNode(text: "Drag this key to the document!")
            keyMessage.fontSize = 16
            keyMessage.position = CGPoint(x: frame.width - 150, y: frame.height - 180)
            keyMessage.fontName = "AvenirNext-Bold"
            keyMessage.zPosition = 3
            keyMessage.fontColor = UIColor.systemBlue.withAlphaComponent(0.5)
            //        encryptLabel.alpha = 0
            addChild(keyMessage)
            
            addChild(key)
        }else{
            addChild(documentMessage)
        }
        
        nina.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5))
        
        nina.physicsBody?.isDynamic = true
        nina.physicsBody?.categoryBitMask = Bitmasks.nina
        nina.physicsBody?.pinned = true
//        nina.physicsBody?.contactTestBitMask = Bitmasks.virus
        
        jake.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5))
        
        jake.physicsBody?.isDynamic = true
        jake.physicsBody?.affectedByGravity = false
//        jake.physicsBody?.mass = 10000
        jake.physicsBody?.pinned = true
        jake.physicsBody?.categoryBitMask = Bitmasks.jake
        jake.physicsBody?.contactTestBitMask = Bitmasks.document
        
        if encrypted{
            document.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5) + 20)
//            document.addCircle(radius: player.size.width * (0.5) + 20, edgeColor: .green, filled: true)
            
            
            //setup key
            key.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5))
            key.physicsBody?.isDynamic = true
            key.physicsBody?.categoryBitMask = Bitmasks.key
            key.physicsBody?.contactTestBitMask = Bitmasks.document
            key.physicsBody?.collisionBitMask = 0
            
            key.physicsBody?.affectedByGravity = false
            key.physicsBody?.friction = 0
            key.physicsBody?.angularDamping = 0
            key.physicsBody?.linearDamping = 0.025
            key.physicsBody?.restitution = 0.0
            key.physicsBody?.allowsRotation = false
            
        }else{
            
        }
        
        document.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5))
        document.physicsBody?.isDynamic = false
        document.physicsBody?.categoryBitMask = Bitmasks.document
        document.physicsBody?.contactTestBitMask = Bitmasks.jake
        
        document.physicsBody?.affectedByGravity = false
        document.physicsBody?.friction = 0
        document.physicsBody?.angularDamping = 0
        document.physicsBody?.linearDamping = 0.025
        document.physicsBody?.restitution = 0.0
        document.physicsBody?.allowsRotation = false
        
        
        for _ in 1...numberOfPeople {
            createPerson()
        }
        
        
        for person in people {
            person.physicsBody?.applyImpulse(CGVector(dx: CGFloat(arc4random_uniform(maxPersonSpeed)) - (CGFloat(maxPersonSpeed) * 0.5), dy: CGFloat(arc4random_uniform(maxPersonSpeed)) - (CGFloat(maxPersonSpeed) * 0.5)))
        }
        
        
    }
    
    
    func createPerson(){
        let name = "Smiling Devil Emoji.png" //arc4random_uniform(2) == UInt32(1) ? "Unicorn.png" : "Smiling Devil Emoji.png"
        let person = SKSpriteNode(texture: SKTexture(image: UIImage(named: name)!), color: .clear, size: CGSize(width: size.width*0.05, height: size.width*0.05))
        
        person.position = CGPoint(x: positionWithin(range: 0.8, containerSize: size.width), y: positionWithin(range: 0.8, containerSize: size.height))
        
        while distanceFrom(posA: person.position, posB: player.position) < person.size.width * 5{
            person.position = CGPoint(x: positionWithin(range: 0.8, containerSize: size.width), y: positionWithin(range: 0.8, containerSize: size.height))
        }
        
        addChild(person)
        people.append(person)
        
        person.physicsBody = SKPhysicsBody(circleOfRadius: person.size.width * (0.4))
        
        person.physicsBody?.affectedByGravity = false
        person.physicsBody?.categoryBitMask = Bitmasks.hackers
        person.physicsBody?.contactTestBitMask = Bitmasks.document
        
        person.physicsBody?.friction = 0
        person.physicsBody?.angularDamping = 0
        person.physicsBody?.linearDamping = 0.025
        person.physicsBody?.restitution = 1.0
        person.physicsBody?.allowsRotation = false
        
//        person.alpha = 0.65
        
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver else { return }
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let touchNodes = nodes(at: touchLocation)
        
        for node in touchNodes{
            if node == document{
                movingPlayer = true
                offset = CGPoint(x: touchLocation.x - document.position.x, y: touchLocation.y - document.position.y)
            }else if node == key{
                movingKey = true
                offset = CGPoint(x: touchLocation.x - key.position.x, y: touchLocation.y - key.position.y)
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver && (movingPlayer || movingKey) else { return }
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        let newPlayerPosition = CGPoint(x: touchLocation.x - offset.x, y: touchLocation.y - offset.y)
        
        if movingPlayer{
            UIView.animate(withDuration: 1.5) {
                self.documentMessage.alpha = 0
             }
            self.movedDocument = true
            document.run(SKAction.move(to: newPlayerPosition, duration: 0.01))
        }
        
        if movingKey{
            UIView.animate(withDuration: 1.5) {
               self.keyMessage.alpha = 0
            }
            key.run(SKAction.move(to: newPlayerPosition, duration: 0.01))
        }
        
        // For Smoothening
        
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.movingPlayer = false
        self.movingKey = false
    }
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if(contact.bodyA.categoryBitMask == Bitmasks.hackers && contact.bodyB.categoryBitMask == Bitmasks.document){
            print("The hacker has read your message!")
            if(didEncryptDocument || !movedDocument){
                
            }else{
                triggerGameOver()
            }

        }else if (contact.bodyA.categoryBitMask == Bitmasks.document && contact.bodyB.categoryBitMask == Bitmasks.hackers){
            if(didEncryptDocument || !movedDocument){
                
            }else{
                triggerGameOver()
            }

        }else if(contact.bodyA.categoryBitMask == Bitmasks.jake && contact.bodyB.categoryBitMask == Bitmasks.document){
            triggerGameSuccess()

        }else if (contact.bodyA.categoryBitMask == Bitmasks.document && contact.bodyB.categoryBitMask == Bitmasks.jake){
            triggerGameSuccess()

        }else if(contact.bodyA.categoryBitMask == Bitmasks.key && contact.bodyB.categoryBitMask == Bitmasks.document){
            triggerEncryptDocument()

        }else if (contact.bodyA.categoryBitMask == Bitmasks.document && contact.bodyB.categoryBitMask == Bitmasks.key){
            triggerEncryptDocument()

        }else{

        }
//        print(contact.bodyA.categoryBitMask , contact.bodyB.categoryBitMask)
    }
    
    func fadeOutHackers(){
        for peep in people{
            UIView.animate(withDuration: 1.5) {
                peep.alpha = 0

            }
        }
    }
    
    
    func triggerGameOver(){
        gameOver = true
        
        for person in people{
            person.physicsBody?.velocity = .zero
        }
        
        let gameOverLabel = SKLabelNode(text: "DOCUMENT HACKED")
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverLabel.fontName = "AvenirNext-Bold"
        gameOverLabel.zPosition = 3
        gameOverLabel.fontColor = UIColor.systemRed.withAlphaComponent(0.8)
        
        let messageLabel = SKLabelNode(text: self.message)
        messageLabel.fontSize = 25
        messageLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        messageLabel.fontName = "AvenirNext-Bold"
        messageLabel.zPosition = 3
        messageLabel.fontColor = UIColor.systemRed.withAlphaComponent(0.5)
        
        
        addChild(gameOverLabel)
        addChild(messageLabel)
        
        fadeOutNodes(people)
        
    }
    
    func triggerGameSuccess(){
        gameOver = true
        
        for person in people{
            person.physicsBody?.velocity = .zero
        }
        
        let gameOverLabel = SKLabelNode(text: "Messaged successfully delivered!")
        gameOverLabel.fontSize = 40
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverLabel.fontName = "AvenirNext-Bold"
        gameOverLabel.zPosition = 3
        gameOverLabel.fontColor = UIColor.systemBlue.withAlphaComponent(0.8)
        
        let messageLabel = SKLabelNode(text: self.message)
        messageLabel.fontSize = 25
        messageLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        messageLabel.fontName = "AvenirNext-Bold"
        messageLabel.zPosition = 3
        messageLabel.fontColor = UIColor.systemBlue.withAlphaComponent(0.5)
//        animateNodes([gameOverLabel])
        addChild(gameOverLabel)
        addChild(messageLabel)
        fadeOutNodes(people)
        
    }
    
    
    func triggerEncryptDocument(){
        document.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width * (0.5) + 20)
        document.addCircle(radius: player.size.width * (0.5) + 20, edgeColor: UIColor.systemTeal, filled: true)
        document.physicsBody?.isDynamic = false
        document.physicsBody?.categoryBitMask = Bitmasks.document
        document.physicsBody?.contactTestBitMask = Bitmasks.jake
        
        document.physicsBody?.affectedByGravity = false
        document.physicsBody?.friction = 0
        document.physicsBody?.angularDamping = 0
        document.physicsBody?.linearDamping = 0.025
        document.physicsBody?.restitution = 0.0
        document.physicsBody?.allowsRotation = false
        
        key.removeFromParent()
        
        self.didEncryptDocument = true
        
        let encryptLabel = SKLabelNode(text: "Document Encrypted")
        encryptLabel.fontSize = 20
        encryptLabel.position = CGPoint(x: frame.midX, y: 150)
        encryptLabel.fontName = "AvenirNext-Bold"
        encryptLabel.zPosition = 3
        encryptLabel.fontColor = UIColor.systemBlue.withAlphaComponent(0.5)
//        encryptLabel.alpha = 0
        addChild(encryptLabel)
    }
    
    func makePlayersSad(){
//        nina.texture
    }
    
    func animateNodes(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    .scale(to: 1.15, duration: 0.3),
                    .scale(to: 1, duration: 0.3),
                    .wait(forDuration: 0.8)
                ]))
            ]))
        }
    }
    
    func fadeOutNodes(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.1),
                .fadeAlpha(to: 0, duration: 0.4)
            ]))
        }
    }
    
    func flashNode(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.1),
                .fadeAlpha(to: 0, duration: 0.4)
            ]))
        }
    }
}



extension SKNode {
    func addCircle(radius: CGFloat, edgeColor: UIColor, filled: Bool){
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.zPosition = -3;
        circle.strokeColor = edgeColor
        circle.fillColor = filled ? edgeColor.withAlphaComponent(0.3) : .clear
        addChild(circle)
    }
    
    func addText(text: String){
        let label = SKLabelNode(text: text)
        label.fontColor = .blue
        label.fontSize = 24
        label.position = .init(x: 0, y: -50)
        label.zPosition = 1
        addChild(label)
    }
}
