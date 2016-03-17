//
//  SessionModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class SessionModel: NSObject {
   public var chat_session_id:String?
   public var chat_session_type:String?
   public var last_message:String?
   public var last_message_id:String?
   public var last_message_time:String?
   public var last_message_type:String?
   public var last_sender_id:String?
   public var message_count:String?
   public var target_id:String?
   public var target_name:String?
   public var target_online_status:String?
   public var target_picture:String?
    
    func SessionListModelMethod(ArrDict arrDict:Array<AnyObject>)->Array<SessionModel>{
        var arr:Array<SessionModel> = Array()
        for dic in arrDict{
            let model:SessionModel = SessionModel()
            
            model.chat_session_id = dic["chat_session_id"] as? String
            
            let chat_session_type = dic["chat_session_type"]!
            model.chat_session_type = String(chat_session_type!)
            
            model.last_message = dic["last_message"] as? String
            
            model.last_message_id = dic["last_message_id"] as? String
            let last_message_time = dic["last_message_time"]!
            model.last_message_time = String("\(last_message_time!)")
            
            let last_message_type = dic["last_message_type"]!
            model.last_message_type = String(last_message_type!)
            model.last_sender_id = dic["last_sender_id"] as? String
            
            
            let message_count = dic["message_count"]!
            model.message_count = String(message_count!)
            model.target_id = dic["target_id"] as? String
            
            model.target_name = dic["target_name"] as? String
            
            let target_online_status = dic["target_online_status"]!
            model.target_online_status = String(target_online_status!)
            
            let target_picture = dic["target_picture"]!
            model.target_picture =  String(target_picture!)
            
            arr.append(model)
        }
        return arr
    }
}
