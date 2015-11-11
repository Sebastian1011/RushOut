//
//  PlayScene.swift
//  RushOut
//
//  Created by 张子名 on 11/1/15.
//  Copyright © 2015 tingdao. All rights reserved.
//

import SpriteKit
var percent = 0.0
var showCount: String!
class PlayScene: SKScene {
    
    let timeLabel = SKLabelNode(fontNamed: "Geneva")
    var counter = 10.0
    var past:CGPoint!
    var now:CGPoint!
    var start = 0.0
    var end = 0.0
    var Sum = 0.0
    var judge = 1
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.blackColor()
        timeLabel.text = "10"
        timeLabel.position = CGPointMake(frame.midX, frame.midY+200)
        timeLabel.fontColor = UIColor.whiteColor()
        timeLabel.fontSize = 60
        self.addChild(timeLabel)
        //self.view!.backgroundColor = UIColor.whiteColor()
        countdown()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location: CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
        
        start = Double(location.y)
        past = location
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location: CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
        end = Double(location.y)
        now = location
        if end>start {
            Sum = Sum+(end-start)
            
        }else{
            print(0)
        }
        percent = Sum/19000
        let color = CGFloat(percent)
        self.backgroundColor = UIColor(white: color, alpha: 1)
        if (percent >= 1) {
            let nextScene = ResultScene(size: self.size )
            self.view?.presentScene(nextScene)
        }
        print(percent)
        //drawLine(now, past: past)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let currentPoint:CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
        let previousPoint:CGPoint! = (touches as NSSet).anyObject()?.previousLocationInNode(self)
        drawLine(currentPoint, past: previousPoint)
    }
    
    
    // draw a line according to the touchesmoved
    func drawLine(now: CGPoint, past:CGPoint){
        
        
        let shapeNode = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, past.x, past.y)
        CGPathAddLineToPoint(path, nil, now.x, now.y)
        shapeNode.path = path
        shapeNode.glowWidth = 2.0
        shapeNode.lineWidth = 4.0
        shapeNode.strokeColor = UIColor.yellowColor()
        shapeNode.antialiased = true
        
        
        
        /*CGPathAddArc(path, nil, 0, 0, 45, 0, 360, true);
        CGPathCloseSubpath(path);
        shapeNode.path = path;
        shapeNode.lineWidth = 2.0;
        shapeNode.position = CGPoint(x:now.x,y:now.y);
        
        // Set the ball's physical properties
        shapeNode.physicsBody = SKPhysicsBody(circleOfRadius: shapeNode.frame.width/2);
        shapeNode.physicsBody!.dynamic = true;
        shapeNode.physicsBody!.mass = 1;
        shapeNode.physicsBody!.friction = 0.2;
        shapeNode.physicsBody!.restitution = 1;
        
        
        // Now make the edges of the screen a physics object as well
        scene!.physicsBody = SKPhysicsBody(edgeLoopFromRect: view!.frame);
        
        // Make gravity "fall" at 1 unit per second along the y-axis
        self.physicsWorld.gravity.dy = -1
        */
        self.addChild(shapeNode)
        //设置等待0.1秒的时间直线消失
        let lineWait = SKAction.runBlock({
            shapeNode.removeFromParent()
        })
        let waitForLine = SKAction.repeatActionForever(SKAction.sequence([SKAction.waitForDuration(0.1),lineWait]))
        shapeNode.runAction(waitForLine, withKey: "waitForLine")
        //SKAction.waitForDuration(1)
        //shapeNode.removeFromParent()
    }
    //using the touchesmoved method 
    /*override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let currentPoint:CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
        let previousPoint:CGPoint! = (touches as NSSet).anyObject()?.previousLocationInNode(self)
        backgroundCount = backgroundCount + Double(currentPoint.y - previousPoint.y)
        percent = backgroundCount/30000
        
        //let color = CGFloat(percent)
        //self.backgroundColor = UIColor(white: color, alpha: 1)
        //print(percent)
        print(currentPoint)
        
    }*/
    
    // the countdown in the playScene
    func countdown(){
        
        let updateCounter = SKAction.runBlock({
            self.counter = self.counter - 0.01
            showCount = String(format: "%.2f", self.counter)
            if (self.counter <= 4.0){
                self.timeLabel.fontColor = UIColor.redColor()
            }
            self.timeLabel.text = "\(showCount)秒"
            
            if(self.counter <= 0.0){
                self.stop()
                let backScene = ResultScene(size: self.size)
                //let flip = SKTransition.flipVerticalWithDuration(0.5)
                self.view?.presentScene(backScene)
            }
            
            
        })
        
        let countdown = SKAction.repeatActionForever(SKAction.sequence([SKAction.waitForDuration(0.01),updateCounter]))
        
        
        //You can run an action with key. Later, if you want to stop the timer, are affect in any way on this action, you can access it by this key
        timeLabel.runAction(countdown, withKey:"countdown")
        
    }
    
    //wait for 0.1 second before the remove the lineNode
    func stop(){
        
        if(timeLabel.actionForKey("countdown") != nil){
            
            
            timeLabel.removeActionForKey("countdown")
            
        }
        
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
}
