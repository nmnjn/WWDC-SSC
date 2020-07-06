//
//  WelcomeScene.swift
//  BookCore
//
//  Created by Naman Jain on 17/05/20.
//

import SpriteKit
import UIKit

public class WelcomeScene: SKScene, SKPhysicsContactDelegate{

    var nina: SKSpriteNode!
    
    public override func didMove(to view: SKView) {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0.0
        
        physicsWorld.contactDelegate = self
        
        //Background
//          let bg = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "IMG_0348.JPG")))
//          bg.setScale(0.1)
//          bg.zPosition = -20
//          bg.position = CGPoint(x: frame.midX, y: frame.midY)
        
//          addChild(bg)
        
        
        nina = SKSpriteNode(texture: SKTexture(image: UIImage(named: "Nina.png")!), color: .clear, size: CGSize(width: size.width*0.09, height: size.width*0.09))
        
        nina.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(nina)
        
        nina.physicsBody = SKPhysicsBody(circleOfRadius: 100)
        nina.physicsBody?.isDynamic = true
        nina.physicsBody?.categoryBitMask = Bitmasks.nina
        nina.physicsBody?.pinned = true
        
        
        animateNodes([nina])
        
    }
    
    
    func fadeOutNodes(_ nodes: [SKNode]){
        for node in nodes{
            UIView.animate(withDuration: 1.5) {
                node.alpha = 0
            }
        }
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
    
    func fadeOut(_ nodes: [SKNode]) {
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
