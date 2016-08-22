//
//  MenuScene.swift
//  SuperCat
//
//  Created by Craig Clayton on 8/20/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    let tapSelectedRec = UITapGestureRecognizer()
    let tapPlayPauseRec = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        createBackground()
        addTapGestureRecognizers()
        addMenuTapGestureRecognizers()
    }
    
    
    
    func createBackground() {
        
        let mainBackgroundTexture = SKTexture(imageNamed: "background")
        let mainBackground = SKSpriteNode(texture:mainBackgroundTexture)
        mainBackground.anchorPoint = CGPoint.zero
        mainBackground.zPosition = -99
        
        self.addChild(mainBackground)
        
        let gameOverTexture = SKTexture(imageNamed: "game-over")
        let gameOverTxt = SKSpriteNode(texture:gameOverTexture)
//        gameOverTxt.anchorPoint = CGPoint.zero
        gameOverTxt.anchorPoint = CGPointMake(0.5, 0.5)
        gameOverTxt.zPosition = -97
        gameOverTxt.position = CGPointMake(918, 614)
        
        self.addChild(gameOverTxt)
        
        let backgroundTexture = SKTexture(imageNamed: "city")
        
        //move background right to left; replace
        let shiftBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 5)
        let replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y:0, duration: 0)
        let movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        for i in 0..<2 {
            //defining background; giving it height and moving width
            let background = SKSpriteNode(texture:backgroundTexture)
            background.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * CGFloat(i)), y: CGRectGetMidY(self.frame))
            background.zPosition = -98
            background.size.height = self.frame.height
            background.runAction(movingAndReplacingBackground)
            
            self.addChild(background)
        }
    }
    
    func addTapGestureRecognizers() {
        tapPlayPauseRec.addTarget(self, action: #selector(GameOverScene.onPlayPauseTapped))
        tapPlayPauseRec.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)]
        view!.addGestureRecognizer(tapPlayPauseRec)
    }
    
    func removeTapGestureRecognizers() {
        view!.removeGestureRecognizer(tapPlayPauseRec)
    }
    
    func addMenuTapGestureRecognizers() {
        tapSelectedRec.addTarget(self, action: #selector(GameOverScene.onSelectedTapped))
        tapSelectedRec.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view!.addGestureRecognizer(tapSelectedRec)
    }
    
    func removeMenuTapGestureRecognizers() {
        view!.removeGestureRecognizer(tapSelectedRec)
    }
    
    func onSelectedTapped() {
        transitionToMenu()
    }
    
    func onPlayPauseTapped() {
        transitionToMenu()
    }
    
    func transitionToMenu() {
        let menuScene = MenuScene(size: size)
        menuScene.scaleMode = scaleMode
        
        if let scene = MenuScene(fileNamed: "MenuScene") {
            let skView = self.view! as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = false
            scene.scaleMode = .ResizeFill
            skView.showsPhysics = true
            
            let reveal = SKTransition.fadeWithDuration(1)
            skView.presentScene(scene, transition: reveal)
        }
    }
}
