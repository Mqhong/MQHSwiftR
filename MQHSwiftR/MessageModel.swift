//
//  MessageModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class MessageModel: NSObject {
    
    public var chat_session_id:String?
    public var chat_session_type:String?
    public var sender_id:String?
    public  var message_id:String?
    public var message:String?
    public var message_time:String?
    public var message_type:String?
    public var message_token:String?
    
    func MessageModelMethodWithDict(Dict dict:Dictionary<String,AnyObject>)->MessageModel{
        let model:MessageModel = MessageModel()
        model.chat_session_id = dict["chat_session_id"] as? String
        model.chat_session_type = String(dict["chat_session_type"]!)
        
        let message = dict["message"]!
        model.message =  String(message)
        model.message_id = dict["message_id"] as? String
        model.message_time = String(dict["message_time"]!)
        
        let message_token = dict["message_token"]!
        model.message_token = String(message_token)
        model.message_type = String(dict["message_type"]!)
        model.sender_id = dict["sender_id"] as? String
        return model
    }
    
    
    func MessageModelMethodWithArrDict(ArrDict arrdict:Array<AnyObject>)->Array<MessageModel>{
        
        var arr:Array<MessageModel> = Array()
        
        for dic in arrdict{
            
            var model:MessageModel = MessageModel()
            
            model = model.MessageModelMethodWithDict(Dict: dic as! Dictionary<String, AnyObject>)
            
            arr.append(model)
        }
        return arr
        
    }
    
    
}
