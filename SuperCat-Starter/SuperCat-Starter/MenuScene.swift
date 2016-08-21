//
//  MenuScene.swift
//  SuperCat-Starter
//
//  Created by Craig Clayton on 8/21/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import SpriteKit


class MenuScene: SKScene {

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
        let backgroundTexture = SKTexture(imageNamed: "city")
        
        let shiftBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 5)
        let replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y:0, duration: 0)
        let movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        for i in 0..<2 {
            let background = SKSpriteNode(texture:backgroundTexture)
            background.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * CGFloat(i)), y: CGRectGetMidY(self.frame))
            background.zPosition = -9
            background.size.height = self.frame.height
            background.runAction(movingAndReplacingBackground)
            
            self.addChild(background)
        }
    }
    
    func addTapGestureRecognizers() {
    }
    
    func removeTapGestureRecognizers() {
        view!.removeGestureRecognizer(tapPlayPauseRec)
    }
    
    func onSelectedTapped() {
        transitionToGame()
    }
    
    func onPlayPauseTapped() {
        transitionToGame()
    }
    
    func transitionToGame() {
        
    }
}


