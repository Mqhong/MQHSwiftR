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
        
        model.chat_session_id = self.Diction_Str(dict, keystr: "chat_session_id")
        
        model.chat_session_type = self.Diction_Str(dict, keystr: "chat_session_type")
        
        model.message =  self.Diction_Str(dict, keystr: "message")
        
        model.message_id = self.Diction_Str(dict, keystr: "message_id")
        
        model.message_time = self.Diction_Str(dict, keystr: "message_time")
        
        model.message_token = self.Diction_Str(dict, keystr: "message_token")
        
        model.message_type = self.Diction_Str(dict, keystr: "message_type")
        
        model.sender_id = self.Diction_Str(dict, keystr: "sender_id")
        
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
    
    private func Diction_Str(dict:AnyObject,keystr:String)->String{
        let str = dict[keystr]!
        return String(str!)
    }
    
}
