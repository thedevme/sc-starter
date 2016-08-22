//
//  GameScene.swift
//  SuperCat
//
//  Created by Craig Clayton on 8/13/16.
//  Copyright (c) 2016 Cocoa Academy. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: SKSpriteNodes
    var heroNode:SKSpriteNode?
    var asteroidNode:SKSpriteNode?
    var frontBackground:SKSpriteNode?
    var backBackground:SKSpriteNode?
    var background:SKSpriteNode?
    var health:Health?
    var healthBar:HealthBar?
    
    var backgroundSound:SKNode!
    let mainBackground = SKSpriteNode(texture:SKTexture(imageNamed: "background"))
    
    // MARK: Floats
    let asteroidRadius = [CGFloat(34), CGFloat(60), CGFloat(120), CGFloat(34), CGFloat(60), CGFloat(120)]
   
    // Mark: Tap Gesture
    let tapPlayPauseRec = UITapGestureRecognizer()
   
    // MARK: - Methods
    override func didMoveToView(view: SKView) {
        setupPhysicsWorld()
        createBackground()
        createHero()
        addTapGestureRecognizers()
        createAsteroids()
        createHealthBar()
    }
    
    override func update(currentTime: CFTimeInterval) {
        updateHero()
        updateHealth()
    }
    
    // MARK: - Gesture Recognizers
    
    func addTapGestureRecognizers() {
        tapPlayPauseRec.addTarget(self, action: #selector(GameScene.onFirePressed))
        tapPlayPauseRec.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        view!.addGestureRecognizer(tapPlayPauseRec)
    }
    
    func onFirePressed() {
        spawnBullet()
    }
    
    func setupPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }

    
    // MARK: - Create Background
    func createBackground() {
        mainBackground.anchorPoint = CGPoint.zero
        mainBackground.zPosition = -99
        self.addChild(mainBackground)
        
        let backgroundTexture = SKTexture(imageNamed: "city")
        
        let shiftBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 5)
        let replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y:0, duration: 0)
        let movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        for i in 0..<2 {
            //defining background; giving it height and moving width
            background=SKSpriteNode(texture:backgroundTexture)
            background!.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * CGFloat(i)), y: CGRectGetMidY(self.frame))
            background?.zPosition = -9
            background!.size.height = self.frame.height
            background!.runAction(movingAndReplacingBackground)
            
            self.addChild(background!)
        }
    }
    
    // MARK: - Hero Methods
    
    // Create Hero
    func createHero() {
        
        let player1Texture = SKTextureAtlas(named:"blackcat")
        heroNode = SKSpriteNode(texture: player1Texture.textureNamed("black_idle_1"), size: CGSizeMake(192, 129))
        guard let hero = heroNode else { return }
        
        hero.position = CGPointMake(169, 590)
        hero.physicsBody = SKPhysicsBody.init(rectangleOfSize: hero.size)
        hero.physicsBody?.categoryBitMask = Game.ColliderType.HeroCategory.rawValue
        hero.physicsBody?.contactTestBitMask = Game.ColliderType.AsteroidCategory.rawValue
        hero.physicsBody?.dynamic = false
        hero.physicsBody?.affectedByGravity = false
        createHeroIdleAnimation(hero)
        
        addChild(hero)
    }
    
    // Hero Idle Animation
    func createHeroIdleAnimation(hero:SKSpriteNode) {
        var animFrames = [SKTexture]()
        
        let idleTexture = SKTextureAtlas(named: "blackcat")
        let numImages = 2
        
        for i in 0 ..< numImages {
            let idleTextureName = "black_idle_\(i+1)"
            animFrames.append(idleTexture.textureNamed(idleTextureName))
        }
        
        hero.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(animFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)), withKey:"idleAnimation")
    }
    
    // Hero Fire Animation
    func createHeroFireAnimation() {
        var animFrames = [SKTexture]()
        
        let shootTexture = SKTextureAtlas(named: "blackcat")
        let numImages = 2
        
        for i in 0 ..< numImages {
            let shootTextureName = "black_shoot_\(i+1)"
            animFrames.append(shootTexture.textureNamed(shootTextureName))
        }
        
        guard let hero = heroNode else { return }
        
        hero.runAction(
            SKAction.animateWithTextures(animFrames,
                timePerFrame: 0.15,
                resize: false,
                restore: true), withKey:"fire")
    }
    
    // Hero Hit Animation
    func createHeroHitAnimation() {
        var animFrames = [SKTexture]()
        
        let hurtTexture = SKTextureAtlas(named: "blackcat")
        let numImages = 1
        
        for i in 0 ..< numImages {
            let hurtTextureName = "black_hurt_\(i+1)"
            animFrames.append(hurtTexture.textureNamed(hurtTextureName))
        }
        
        guard let hero = heroNode else { return }
        
        hero.runAction(
            SKAction.animateWithTextures(animFrames,
                timePerFrame: 0.15,
                resize: false,
                restore: true), withKey:"hurt")
    }
    
    // Hero Bullet
    func spawnBullet() {
        let bullet = SKSpriteNode(imageNamed: "cat_shot_1")
        
        bullet.zPosition = -5
        
        guard let hero = heroNode else { return }
        bullet.position = CGPointMake(hero.position.x+50, hero.position.y-35)
        
        
        createBulletAnimation(bullet)
        createHeroFireAnimation()
    }
    
    // Hero Bullet Animation
    func createBulletAnimation(bullet:SKSpriteNode) {
        var animFrames = [SKTexture]()
        let bulletTexture = SKTextureAtlas(named: "bullet")
        let numImages = 2
        
        for i in 0 ..< numImages {
            let ballTextureName = "cat_shot_\(i+1)"
            animFrames.append(bulletTexture.textureNamed(ballTextureName))
        }
        
        bullet.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(animFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)), withKey:"bulletAnimation")
        
        let action = SKAction.moveToX(self.size.width+50, duration: 0.75)
        let actionDone = SKAction.removeFromParent()
        
        bullet.runAction(SKAction.sequence([action, actionDone]))
        bullet.physicsBody = SKPhysicsBody.init(rectangleOfSize: bullet.size)
        bullet.physicsBody?.categoryBitMask = Game.ColliderType.BulletCategory.rawValue
        bullet.physicsBody?.contactTestBitMask = Game.ColliderType.AsteroidCategory.rawValue
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.dynamic = false
        addChild(bullet)
    }
    
    // Move Hero
    func moveHero(hero:SKSpriteNode, y:Float) {
        let reverseDirection = y
        
        var vector = CGFloat(reverseDirection * 5)
        vector = CGFloat(reverseDirection * 15)
        
        var calculatedY = hero.position.y + (vector * -1)
        let max = 802 as CGFloat
        let min = 280 as CGFloat
        
        if (calculatedY > max) { calculatedY = max }
        if (calculatedY < min) { calculatedY = min }
        
        let yPosition = CGFloat(calculatedY)
        
        hero.position = CGPointMake(hero.position.x, yPosition)
    }
    
    // Update Hero
    func updateHero() {
        for i in 0..<GameViewController.controllers.count {
            let gameViewController = GameViewController()
            let direction = gameViewController.controllerDirection(controllerIndex: i)
            
            if direction.y > 0.0002 || direction.y < -0.0002 {
                moveHero(heroNode!, y: direction.y)
            }
        }
    }
    
    // Create Health Bar
    func createHealthBar() {
        let width = size.width * 0.7
        let height = size.height * 0.05
        
        health = Health.init()
        healthBar = HealthBar.init(width: width, height: height)
        healthBar?.position = CGPointMake(size.width / 2.0, size.height - healthBar!.barHeight!)
        addChild(healthBar!)
    }
    
    func updateHealth() {
        healthBar?.updateWithHealth(health!)
    }
    
    // MARK: - Asteroid Methods
    
    
    // Create Asteroids
    func createAsteroids() {
        let _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameScene.spawnAsteroids), userInfo: nil, repeats: true)
    }
    
    // Spawn Asteroids
    func spawnAsteroids() {
        let asteroids = [Game.Asteroid.Small.node("red"), Game.Asteroid.Medium.node("red"), Game.Asteroid.Large.node("red"), Game.Asteroid.Small.node("brown"), Game.Asteroid.Medium.node("brown"), Game.Asteroid.Large.node("brown")]
        let randomIndex = Int(arc4random_uniform(UInt32(asteroids.count)))
        
        let minValue = size.height / 8
        let maxValue = size.height - 20
        let spawnPoint = UInt32(maxValue - minValue)
        
        let rotation = SKAction.rotateByAngle(CGFloat(M_PI/2.0), duration: 4.0)
        let actionDone = SKAction.removeFromParent()
        let asteroid = asteroids[randomIndex]
        
        asteroid.physicsBody = SKPhysicsBody.init(circleOfRadius: asteroidRadius[randomIndex])
        asteroid.physicsBody?.categoryBitMask = Game.ColliderType.AsteroidCategory.rawValue
        asteroid.physicsBody?.contactTestBitMask = Game.ColliderType.BulletCategory.rawValue
        asteroid.physicsBody?.affectedByGravity = false
        asteroid.physicsBody?.dynamic = true
        asteroid.position = CGPointMake(size.width, CGFloat(arc4random_uniform(spawnPoint)))
        
        addChild(asteroid)
        
        let action = SKAction.moveToX(-300, duration: 3.0)
        asteroid.runAction(SKAction.sequence([action, actionDone]))
        asteroid.runAction(SKAction.repeatActionForever(rotation))
    }
    
    // MARK - GAME OVER
    
    func showGameOver() {
        if health!.current <= 0 {
            if let gameScene = GameOverScene(fileNamed: "GameOverScene") {
                let skView = self.view! as SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.ignoresSiblingOrder = false
                gameScene.scaleMode = .ResizeFill
                skView.showsPhysics = true
                
                let reveal = SKTransition.fadeWithDuration(1)
                skView.presentScene(gameScene, transition: reveal)
            }
        }
    }
    
    //MARK: - Physics Contact Delegate
    func didBeginContact(contact: SKPhysicsContact)
    {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == Game.ColliderType.HeroCategory.rawValue && secondBody.categoryBitMask == Game.ColliderType.AsteroidCategory.rawValue {
            health?.damage(10)
            collisionWithAsteroid(secondBody.node as! SKSpriteNode, hero: firstBody.node as! SKSpriteNode)
            showGameOver()
        }
        
        if firstBody.categoryBitMask == Game.ColliderType.BulletCategory.rawValue && secondBody.categoryBitMask == Game.ColliderType.AsteroidCategory.rawValue {
            collisionWithBullet(firstBody.node as! SKSpriteNode, bullet: secondBody.node as! SKSpriteNode)
        }
    }
    
    // MARK: - Collision Helper Methods
    func collisionWithBullet(asteroid: SKSpriteNode, bullet: SKSpriteNode) {
        bullet.removeFromParent()
        asteroid.removeFromParent()
    }
    
    func collisionWithAsteroid(asteroid: SKSpriteNode, hero: SKSpriteNode) {
        asteroid.removeFromParent()
        createHeroHitAnimation()
    }
}
