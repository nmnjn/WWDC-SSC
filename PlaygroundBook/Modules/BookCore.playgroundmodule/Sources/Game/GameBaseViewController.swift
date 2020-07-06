//
//  GameBaseViewController.swift
//  BookCore
//
//  Created by Naman Jain on 07/05/20.
//

import Foundation
import UIKit
import PlaygroundSupport
import SpriteKit

public class GameBaseViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    //MARK: - Properties
    let skView: SKView = {
        let view = SKView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        skView.preferredFramesPerSecond = 30
        view.addSubview(skView)
        
        skView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        setupWelcomeScene()
//        self.setupGameScene(message: text, players: number, encrypted: false)
    }
    
    
    public func setupWelcomeScene(){
        let welcomeScene = WelcomeScene(size: UIScreen.main.bounds.size)
        welcomeScene.scaleMode = .aspectFill
        welcomeScene.backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        skView.presentScene(welcomeScene)
    }
    
    
    public func setupGameScene(message: String, players: Int, encrypted: Bool){
        let gameScene = GameScene(size: UIScreen.main.bounds.size)
        gameScene.encrypted = encrypted
        gameScene.numberOfPeople = players
        gameScene.message = message
        gameScene.scaleMode = .aspectFill
        gameScene.backgroundColor = #colorLiteral(red: 0.960831821, green: 0.9571952224, blue: 0.9403633475, alpha: 1)
        skView.presentScene(gameScene)
        
    }
    
    var text = "Hello Jake!"
    var encrypt = false
    var number = 3
    
    //MARK: - Custom Methods
    
    //MARK: - MessageHandler Methods
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .string(text):
            self.text = text
            break
        case let .boolean(encrypt):
            self.encrypt = encrypt
            break
        case let .integer(number):
            self.number = number
            break
        default:
            break
        }
        
        self.setupGameScene(message: text, players: number, encrypted: encrypt)
    }
}

