//
//  ResultScene.swift
//  RushOut
//
//  Created by 张子名 on 11/2/15.
//  Copyright © 2015 tingdao. All rights reserved.
//

import SpriteKit
import Social
import UIKit

class ResultScene: SKScene,UIActionSheetDelegate {
    var shareBtn:SKNode!
    var againBtn:SKNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor(red: 217, green: 217, blue: 25, alpha: 255)
        let success = SKLabelNode(fontNamed: "Geneva")
        let resultLabel = SKLabelNode(fontNamed: "Geneva")
        //let marks = String(format: "%.2f", percent*100)
        //resultLabel.text = "我在游戏中获得了\(marks)分"
        if (percent < 1){
            resultLabel.text = "挑战失败，再接再厉..."
            resultLabel.position = CGPointMake(frame.midX, frame.midY)
            resultLabel.fontSize = 30
        }else{
            
            success.text = "恭喜你，冲破了黑暗！"
            success.fontSize = 30
            let num = 10.0 - Double(showCount)!
            resultLabel.text = "总共花费时间：\(num)秒"
            resultLabel.position = CGPointMake(frame.midX, frame.midY-30)
            resultLabel.fontSize = 25
            let yesMarks = SKSpriteNode(imageNamed: "yes.png")
            yesMarks.position = CGPointMake(frame.midX, frame.midY+150)
            yesMarks.size = CGSize(width: 150, height: 150)
            
            addChild(yesMarks)
        }
        success.position = CGPointMake(frame.midX, frame.midY+20)
        resultLabel.fontColor = UIColor.blackColor()
        success.fontColor = UIColor.blackColor()
        //let cardTexture = SKTexture(imageNamed: "yes.png")
        addChild(success)
        addChild(resultLabel)
        
        let sharePic:SKTexture = SKTexture(imageNamed: "button1.png")
        shareBtn = SKSpriteNode.init(texture: sharePic, color: UIColor.whiteColor(), size: CGSizeMake(120, 60))
        shareBtn.position = CGPoint(x:CGRectGetMidX(self.frame)-80, y:CGRectGetMidY(self.frame)-100);
        
        self.addChild(shareBtn)
        let againPic:SKTexture = SKTexture(imageNamed: "button2.png")
        againBtn = SKSpriteNode.init(texture: againPic, color: UIColor.whiteColor(), size: CGSizeMake(120, 60))
        againBtn.position = CGPoint(x:CGRectGetMidX(self.frame)+80, y:CGRectGetMidY(self.frame)-100);
        
        self.addChild(againBtn)
        
        //super.init(texture: cardTexture, color: nil, size: cardTexture.size())
        

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if shareBtn.containsPoint(location) {
                let actPress = SKAction.scaleTo(0.9, duration: 0.01)
                shareBtn.runAction(actPress,withKey: "drop")
               
                }
                
            if againBtn.containsPoint(location) {
                let actPress = SKAction.scaleTo(0.9, duration: 0.01)
                againBtn.runAction(actPress, withKey: "drop")
            }
        }

        }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if shareBtn.containsPoint(location) {
                let actPress = SKAction.scaleTo(1.0, duration: 0.01)
                shareBtn.runAction(actPress,withKey: "pickup")
                
                
                let num = 10.0 - Double(showCount)!
                //sharing style UIActivityViewController
                let items = ["冲出黑暗", UIImage(named:"share.png")!,
                    NSURL(fileURLWithPath:"http://game.tingdao.me/success/?second=\(num)")]
                //new share array
                let acts = [WeiXinActivity(),MomentsActivity()]
                //share comments and pictures
                let actView:UIActivityViewController =
                UIActivityViewController(activityItems: items, applicationActivities: acts)
                //exclude share button
                actView.excludedActivityTypes = [UIActivityTypeMail,UIActivityTypeCopyToPasteboard,
                    UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeMessage,UIActivityTypeAirDrop,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo]
                //show in view
                self.view?.window?.rootViewController?.presentViewController(actView, animated: true, completion: nil)
                //self.presentViewController(actView, animated:true, completion:nil)
                
                
                /*
                //Sharing style UIActionSheet
                //share to wechat
                //Create the AlertController
                //let shareAction: UIActionSheet = UIActionSheet(title: "分享", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "action")
                
                let actionSheetController: UIAlertController = UIAlertController(title: "分享", message: "让大家膜拜你的手速吧！", preferredStyle: .ActionSheet)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                    //Just dismiss the action sheet
                }
                actionSheetController.addAction(cancelAction)
                
                //Create and add a second option action
                let shareToMomentsAction: UIAlertAction = UIAlertAction(title: "分享到朋友圈", style: .Default)
                    { action -> Void in
                        let num = 10.0 - Double(showCount)!
                        let message =  WXMediaMessage()
                        if (percent >= 1){
                            message.title = "我只用\(num)秒冲出黑暗！你可以吗？"
                            message.description = "我只用\(num)秒冲出黑暗！你可以吗？"
                            message.setThumbImage(UIImage(named:"share.png"))
                            let ext =  WXWebpageObject()
                            ext.webpageUrl = "http://game.tingdao.me/success/?second=\(num)"
                            message.mediaObject = ext
                        }else{
                            message.title = "无影手速竟然没能穿越黑暗，你敢来战么？"
                            message.description = "无影手速竟然没能穿越黑暗，你敢来战么？"
                            message.setThumbImage(UIImage(named:"share.png"))
                            let ext =  WXWebpageObject()
                            ext.webpageUrl = "http://game.tingdao.me/fail"
                            message.mediaObject = ext
                        }
                       
                       
                            
                        let req =  SendMessageToWXReq()
                        req.bText = false
                        req.message = message
                        req.scene = WXSceneTimeline.rawValue
                        WXApi.sendReq(req)

                        
                }
                actionSheetController.addAction(shareToMomentsAction)
                let shareToFriendsAction: UIAlertAction = UIAlertAction(title: "分享给好友", style: .Default)
                    { action -> Void in
                        let num = 10.0 - Double(showCount)!
                        let message =  WXMediaMessage()
                        if (percent >= 1){
                            message.title = "我只用\(num)秒冲出黑暗！你可以吗？"
                            message.description = "我只用\(num)秒冲出黑暗！你可以吗？"
                            message.setThumbImage(UIImage(named:"share.png"))
                            let ext =  WXWebpageObject()
                            ext.webpageUrl = "http://game.tingdao.me/success/?second=\(num)"
                            message.mediaObject = ext
                        }else{
                            message.title = "无影手速竟然没能穿越黑暗，你敢来战么？"
                            message.description = "无影手速竟然没能穿越黑暗，你敢来战么？"
                            message.setThumbImage(UIImage(named:"share.png"))
                            let ext =  WXWebpageObject()
                            ext.webpageUrl = "http://game.tingdao.me/fail"
                            message.mediaObject = ext
                        }
                        
                        let req =  SendMessageToWXReq()
                        req.bText = false
                        req.message = message
                        req.scene = WXSceneSession.rawValue
                        WXApi.sendReq(req)
                        
                }
                actionSheetController.addAction(shareToFriendsAction)
                //The SKScene instance can't invoke presentViewController(_:animated:completion) because it is not a subclass of UIViewController. However, if you rewrite as such, your alert will launch
                self.view?.window?.rootViewController?.presentViewController(actionSheetController, animated: true, completion: nil)
                */
            }

            if againBtn.containsPoint(location) {
                let actPress = SKAction.scaleTo(1.0, duration: 0.01)
                againBtn.runAction(actPress, withKey: "pickup")
                let nextScene = GameScene(size: self.size )
                self.view?.presentScene(nextScene)
                //var img = imageWithView(self.view!)
                //var testImg:SKNode = SKSpriteNode(imageNamed: img)
            }
        }

    }
    
    // get the screenshot from imageView
    func imageWithView(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    // get the screenshot from imageNode
    func imageFromNode(node : SKNode) -> UIImage? {
        if let tex = self.scene?.view?.textureFromNode(node) {
            let view = SKView(frame:CGRectMake(0, 0, tex.size().width, tex.size().height))
            let scene = SKScene(size: tex.size())
            let sprite  = SKSpriteNode(texture: tex)
            sprite.position = CGPoint(x: CGRectGetMidX(view.frame), y: CGRectGetMidY(view.frame))
            scene.addChild(sprite)
            view.presentScene(scene)
            return self.imageWithView(view)
        }
        return nil
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
