//
//  UserStateModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class UserStateModel: NSObject {
//    "user_id" = 1;
//    "user_name" = peterZ;
//    "user_online_status" = 0;
//    "user_picture" = hah;
   public var user_id:String?
   public var user_name:String?
   public var user_online_status:String?
   public var user_picture:String?
    
    func UserStateModelMethodWithDict(Dict dict:Dictionary<String,AnyObject>)->UserStateModel{
        
        let userstatemodel = UserStateModel()
        
        let user_id = dict["user_id"]!
        userstatemodel.user_id =  String(user_id)
        
        let user_name = dict["user_name"]!
        userstatemodel.user_name = String(user_name)
        
        let user_online_status = dict["user_online_status"]!
        userstatemodel.user_online_status = String(user_online_status)
        
        let user_picture = dict["user_picture"]!
        userstatemodel.user_picture = String(user_picture)
        
        return userstatemodel
    }
    
}
