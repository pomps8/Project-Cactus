//
//  GameOverScene.swift
//  Project Cactus 2
//
//  Created by Anthony Pompili on 3/1/16.
//  Copyright © 2016 Anthony Pompili. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let playButton: SKSpriteNode = SKSpriteNode(imageNamed: "playButton.png")
    let quitButton: SKSpriteNode = SKSpriteNode(imageNamed: "quitButton.png")
    var amountOfKillsLabel: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var totalTimeLabel: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    let amountOfKills: Int
    let totalTime: String
    var startTime = NSTimeInterval()
    
    init(size: CGSize, amountOfKills: Int, totalTime: String){
        self.amountOfKills = amountOfKills
        self.totalTime = totalTime
        super.init(size: size)
    }
    
    required init (coder aDecoder: NSCoder) {
        fatalError("init(coder:) had not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        print(totalTime)
        var background: SKSpriteNode
        amountOfKillsLabel.text = "\(amountOfKills)"
        amountOfKillsLabel.position = CGPoint(x: (self.size.width * (2/3)) + 60, y: (self.size.height/2)+60)
        amountOfKillsLabel.zPosition = 7
        amountOfKillsLabel.fontColor = UIColor.init(red: 10, green: 204, blue: 91, alpha: 1.0)
        amountOfKillsLabel.fontSize = 60
        self.addChild(amountOfKillsLabel)
        
        totalTimeLabel.text = totalTime
        totalTimeLabel.position = CGPoint(x: (self.size.width * (2/3)) + 80, y: (self.size.height/2)-180)
        totalTimeLabel.zPosition = 7
        totalTimeLabel.fontColor = UIColor.init(red: 10, green: 204, blue: 91, alpha: 1.0)
        totalTimeLabel.fontSize = 40
        self.addChild(totalTimeLabel)
        
            background = SKSpriteNode(imageNamed: "ScoreBoard")
            runAction(SKAction.sequence([
                SKAction.waitForDuration(0.1),
                SKAction.playSoundFileNamed("Game Over.wav", waitForCompletion: true)
                ]))
        
        playButton.position = CGPoint(x: self.size.width/4, y: 60 )
        playButton.zPosition = 5
        self.addChild(playButton)
        quitButton.position = CGPoint(x: self.size.width * (3/4), y: 60 )
        quitButton.zPosition = 5
        self.addChild(quitButton)
        
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
    }
    
    //called when touch event happends
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //animation for button
        let darkenButton: SKAction = SKAction.colorizeWithColor(UIColor.darkGrayColor(), colorBlendFactor: 1.0, duration: 0.2)
        let lightenButton: SKAction = darkenButton.reversedAction()
        let buttonPressedLook = SKAction.sequence([SKAction.playSoundFileNamed("buttonSound.wav", waitForCompletion: true), darkenButton, lightenButton, SKAction.waitForDuration(5.0)])
        
        //if playbutton is tapped, run game
        for touch: AnyObject in touches {
            if CGRectContainsPoint(playButton.frame, touch.locationInNode(self)) {
                playButton.runAction(buttonPressedLook)
                playButtonTapped()
            } else if CGRectContainsPoint(quitButton.frame, touch.locationInNode(self)) {
                quitButton.runAction(buttonPressedLook)
                quitButtonTapped()
            }
        }
    }
    
    //initializes game and runs it
    func playButtonTapped() {
        let block = SKAction.runBlock {
            //set up scene for game
            let myScene = GameScene(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        self.runAction(block)
        
    }
    
    //initializes main menu and runs it
    func quitButtonTapped() {
        let block = SKAction.runBlock {
            //set up scene for game
            let myScene = MainMenuScene(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        self.runAction(block)
        
    }
    
}