//
//  Health.swift
//  SuperCat-Starter
//
//  Created by Craig Clayton on 8/21/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import Foundation
import UIKit

class Health: NSObject {

    var current:CGFloat?
    var maxValue:CGFloat?
    var regeneration:CGFloat?
    
    override init() {
        maxValue = 100
        current = maxValue
        regeneration = 6.0
    }
    
    func update(time:NSTimeInterval) {
        current = CGFloat(min(maxValue!, current! + (regeneration! * CGFloat(time))))
    }
    
    func damage(amount:CGFloat) {
        current = CGFloat(max(0.0, current! - amount))
    }
}
