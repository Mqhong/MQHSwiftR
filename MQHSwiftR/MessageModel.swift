//
//  MessageModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class MessageModel: NSObject {
    
    var chat_session_id:String?
    var chat_session_type:String?
    var sender_id:String?
    var message_id:String?
    var message:String?
    var message_time:String?
    var message_type:String?
    var message_token:String?
    
    func MessageModelMethodWithDict(Dict dict:Dictionary<String,AnyObject>)->MessageModel{
        let model:MessageModel = MessageModel()
        model.chat_session_id = dict["chat_session_id"] as? String
        model.chat_session_type = String(dict["chat_session_type"]!)
        model.message = dict["message"] as? String
        model.message_id = dict["message_id"] as? String
        model.message_time = String(dict["message_time"]!)
        model.message_token = String(dict["message_token"])
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
