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
            
            model.chat_session_id = self.Diction_Str(dic, keystr: "chat_session_id")
            
            model.chat_session_type = self.Diction_Str(dic, keystr: "chat_session_type")
    
            model.last_message =  self.Diction_Str(dic, keystr: "last_message")
            
            model.last_message_id = self.Diction_Str(dic, keystr: "last_message_id")

            model.last_message_time = self.Diction_Str(dic, keystr: "last_message_time")
            
            model.last_message_type = self.Diction_Str(dic, keystr: "last_message_type")
            
            model.last_sender_id = self.Diction_Str(dic, keystr: "last_sender_id")
            
            model.message_count = self.Diction_Str(dic, keystr: "message_count")
            
            model.target_id = self.Diction_Str(dic, keystr: "target_id")
            
            model.target_name = self.Diction_Str(dic, keystr: "target_name")
            
            model.target_online_status =  self.Diction_Str(dic, keystr: "target_online_status")
            
            model.target_picture = self.Diction_Str(dic, keystr: "target_picture")
            
            arr.append(model)
        }
        return arr
    }
    
    private func Diction_Str(dict:AnyObject,keystr:String)->String{
        let str = dict[keystr]!
        return String(str!)
    }
}
