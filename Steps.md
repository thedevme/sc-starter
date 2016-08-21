Step 1

```swift
func addTapGestureRecognizers() {
    tapPlayPauseRec.addTarget(self, action: #selector(MenuScene.onPlayPauseTapped))
    tapPlayPauseRec.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)]
    view!.addGestureRecognizer(tapPlayPauseRec)
}
```


Step 2

```swift
func transitionToGame() {
    let scene = GameScene(size: size)
    scene.scaleMode = scaleMode
    
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
```
Step 3

```swift
import Foundation
import SpriteKit

class Game {
    enum ColliderType: UInt32
    {
        case HeroCategory = 1
        case BulletCategory = 2
        case AsteroidCategory = 4
    }
    
    enum Asteroid: String {
        case Small
        case Medium
        case Large
        
        func node(color:String) -> SKSpriteNode {
            return SKSpriteNode(imageNamed: "\(color)_" + self.rawValue.lowercaseString + "_asteroid")
        }
    }
}
```

Step 4 
```swift
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
```

Step 5
```swift
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
```

Step 6
```swift
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
```