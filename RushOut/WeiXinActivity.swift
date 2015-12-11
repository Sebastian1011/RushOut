//
//  WeiXinActivity.swift
//  RushOut
//
//  Created by 张子名 on 11/9/15.
//  Copyright © 2015 tingdao. All rights reserved.
//

import UIKit

class WeiXinActivity : UIActivity {
    //used to save share messages
    var text:String!
    var url:NSURL!
    var image:UIImage!
    
    //share name
    override func activityTitle() -> String? {
        return "微信"
    }
    
    //share button icon
    override func activityImage() -> UIImage? {
        return UIImage(named:"wechat_icon.png")
    }
    
    //share type，used for UIActivityViewController.completionHandler
    override func activityType() -> String? {
        return WeiXinActivity.self.description()
    }
    
    //button type:share or action
    override class func activityCategory() -> UIActivityCategory{
        return UIActivityCategory.Share
    }
    
    //whether to show share button
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            if item is UIImage {
                return true
            }
            if item is String {
                return true
            }
            if item is NSURL {
                return true
            }
        }
        return false
    }
    
    //analysis share messages
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        //print("prepareWithActivityItems")
        for item in activityItems {
            if item is UIImage {
                image = item as! UIImage
            }
            if item is String {
                text = item as! String
            }
            if item is NSURL {
                url = item as! NSURL
            }
        }
    }
    
    //share action
    //share to wechat
    override func performActivity() {
        //print("performActivity")
        
    }
    
    //action when sharing
    override func activityViewController() -> UIViewController? {
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

        //print("activityViewController")
        return nil
    }
    
    //action after sharing 
    override func activityDidFinish(completed: Bool) {
        //print("activitydidfinish")
    }
}

