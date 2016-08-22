//
//  MenuScene.swift
//  SuperCat
//
//  Created by Craig Clayton on 8/20/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    let tapSelectedRec = UITapGestureRecognizer()
    let tapPlayPauseRec = UITapGestureRecognizer()

    override func didMoveToView(view: SKView) {
        createBackground()
        createHero()
        addTapGestureRecognizers()
    }
    
    func createHero() {
        let player1Texture = SKTextureAtlas(named:"blackcat")
        
        let hero = SKSpriteNode(texture: player1Texture.textureNamed("menu_idle_1"), size: CGSizeMake(343, 220))
        
        hero.position = CGPointMake(960, 460)
        hero.physicsBody = SKPhysicsBody.init(rectangleOfSize: hero.size)
        hero.physicsBody?.dynamic = false
        hero.physicsBody?.affectedByGravity = false
        
        createHeroIdleAnimation(hero)
        
        addChild(hero)
    }
    
    func createHeroIdleAnimation(hero:SKSpriteNode) {
        var animFrames = [SKTexture]()
        
        let idleTexture = SKTextureAtlas(named: "blackcat")
        let numImages = 2
        
        for i in 0 ..< numImages {
            let idleTextureName = "menu_idle_\(i+1)"
            animFrames.append(idleTexture.textureNamed(idleTextureName))
        }
        
        hero.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(animFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)), withKey:"menuIdleAnimation")
    }
    
    func createBackground() {
        let mainBackgroundTexture = SKTexture(imageNamed: "background")
        let mainBackground = SKSpriteNode(texture:mainBackgroundTexture)
        mainBackground.anchorPoint = CGPoint.zero
        mainBackground.zPosition = -99
        
        self.addChild(mainBackground)
        
        let backgroundTexture = SKTexture(imageNamed: "city")
        
        //move background right to left; replace
        let shiftBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 5)
        let replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y:0, duration: 0)
        let movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        for i in 0..<2 {
            //defining background; giving it height and moving width
            let background = SKSpriteNode(texture:backgroundTexture)
            background.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * CGFloat(i)), y: CGRectGetMidY(self.frame))
            background.zPosition = -9
            background.size.height = self.frame.height
            background.runAction(movingAndReplacingBackground)
            
            self.addChild(background)
        }
    }
    
    func addTapGestureRecognizers() {
        tapPlayPauseRec.addTarget(self, action: #selector(MenuScene.onPlayPauseTapped))
        tapPlayPauseRec.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)]
        view!.addGestureRecognizer(tapPlayPauseRec)
    }
    
    func removeTapGestureRecognizers() {
        view!.removeGestureRecognizer(tapPlayPauseRec)
    }
    
    func onPlayPauseTapped() {
        transitionToGame()
    }
    
    func transitionToGame() {
       
        if let gameScene = GameScene(fileNamed: "GameScene") {
            let skView = self.view! as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = false
            gameScene.scaleMode = .ResizeFill
            skView.showsPhysics = true
            
            let reveal = SKTransition.fadeWithDuration(1)
            skView.presentScene(gameScene, transition: reveal)
        }
        
        removeTapGestureRecognizers()
    }
}
