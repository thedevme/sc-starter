//
//  GameEnums.swift
//  SuperCat
//
//  Created by Craig Clayton on 8/21/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import Foundation
import SpriteKit

class Game {
    
    enum ColliderType: UInt32 {
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