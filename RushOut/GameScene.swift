//
//  GameScene.swift
//  RushOut
//
//  Created by 张子名 on 11/1/15.
//  Copyright (c) 2015 tingdao. All rights reserved.
//
import SpriteKit


class GameScene: SKScene {
    
    var button: SKNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor.blackColor()
        
        let titleLabel = SKLabelNode(fontNamed: "Geneva")
        titleLabel.text = "10秒冲出黑暗"
        titleLabel.position = CGPointMake(frame.midX, (frame.midY+200))
        titleLabel.color = UIColor.whiteColor()
        titleLabel.fontSize = 40
        self.addChild(titleLabel)
        let subTitleLabel = SKLabelNode(fontNamed: "Geneva")
        subTitleLabel.text = "点击开始，疯狂的从屏幕下方向上滑动吧！"
        subTitleLabel.position = CGPointMake(frame.midX, (frame.midY+100))
        subTitleLabel.color = UIColor.whiteColor()
        subTitleLabel.fontSize = 15
        self.addChild(subTitleLabel)
        // Create a simple red rectangle that's 100x44
        //button = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 100, height: 44))
        // Put it in the center of the scene
        let newbutton:SKTexture = SKTexture(imageNamed: "button.png")
        button = SKSpriteNode.init(texture: newbutton, color: UIColor.greenColor(), size: CGSizeMake(150, 145))
        
        button.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-100)
        self.addChild(button)
    }
    func buttonClicked(sender: AnyObject) {
        
        let nextScene = PlayScene(size: self.size )
        self.view?.presentScene(nextScene)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if button.containsPoint(location) {
                let actPress = SKAction.scaleTo(0.9, duration: 0.001)
                button.runAction(actPress,withKey: "drop")
               
            }
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if button.containsPoint(location) {
                buttonClicked(self)
                //let nextScene = PlayScene(size: self.size)
                //self.view?.presentScene(nextScene)
            }
        }
    }
    

    
        override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
