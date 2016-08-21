//
//  HealthBar.swift
//  SuperCat-Starter
//
//  Created by Craig Clayton on 8/21/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import SpriteKit

class HealthBar: SKNode {
    
    var outlineNode:SKShapeNode?
    var fillNode:SKShapeNode?
    
    var barWidth:CGFloat?
    var barHeight:CGFloat?
    
    
    init(width:CGFloat, height:CGFloat) {
        super.init()
        
        barWidth = width
        barHeight = height
        
        let size = CGSizeMake(width, height)
        outlineNode = SKShapeNode.init(rectOfSize: size)
        guard let outline = outlineNode else { return }
        outline.lineWidth = height / 10.0
        outline.fillColor = UIColor.clearColor()
        outline.strokeColor = UIColor.whiteColor()
        outline.zPosition = 2
        addChild(outline)
        
        fillNode = SKShapeNode.init(rectOfSize: size)
        guard let fill = fillNode else { return }
        fill.lineWidth = 0
        fill.fillColor = UIColor.clearColor()
        fill.zPosition = outline.zPosition - 1
        addChild(fill)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateWithHealth(health:Health) {
        let healthProportion = health.current! / health.maxValue!
        let fillWidth = (healthProportion * barWidth!) - outlineNode!.lineWidth + 1
        let fillRect = CGRectMake(-fillWidth / 2.0, -25, fillWidth, barHeight!)
        let path = UIBezierPath.init(rect: fillRect)
        
        fillNode!.path = path.CGPath
        fillNode!.position = CGPointMake(-((outlineNode!.frame.size.width - fillNode!.frame.size.width) / 2.0) + outlineNode!.lineWidth, 0)
        
        let factor:CGFloat = 0.5
        
        if healthProportion < factor {
            fillNode?.fillColor = UIColor.init(colorLiteralRed: Float(factor), green: Float(healthProportion), blue: 0.0, alpha: 1.0)
            
        }
        else {
            fillNode?.fillColor = UIColor.init(colorLiteralRed: 1 - Float(healthProportion) , green:Float(factor), blue: 0.0, alpha: 1.0)
        }
    }
}













