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

    }
    
    func onFirePressed() {
        spawnBullet()
    }
    
    func setupPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    
    // MARK: - Create Background
    func createBackground() {
        
    }
    
    // MARK: - Hero Methods
    
    // Create Hero
    func createHero() {
        
    }
    
    // Hero Idle Animation
    func createHeroIdleAnimation(hero:SKSpriteNode) {
        
    }
    
    // Hero Fire Animation
    func createHeroFireAnimation() {
        
    }
    
    // Hero Hit Animation
    func createHeroHitAnimation() {
        
    }
    
    // Hero Bullet
    func spawnBullet() {
        
    }
    
    // Hero Bullet Animation
    func createBulletAnimation(bullet:SKSpriteNode) {
        
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
        
    }
    
    func updateHealth() {
        
    }
    
    // MARK: - Asteroid Methods
    
    
    // Create Asteroids
    func createAsteroids() {
        
    }
    
    // Spawn Asteroids
    func spawnAsteroids() {
        
    }
    
    // MARK - GAME OVER
    
    func showGameOver() {
        
    }
    
    //MARK: - Physics Contact Delegate
    func didBeginContact(contact: SKPhysicsContact)
    {
        
    }
    
    // MARK: - Collision Helper Methods
    func collisionWithBullet(asteroid: SKSpriteNode, bullet: SKSpriteNode) {
        
    }
    
    func collisionWithAsteroid(asteroid: SKSpriteNode, hero: SKSpriteNode) {

    }
}
