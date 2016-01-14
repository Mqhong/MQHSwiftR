//
//  UserStateModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class UserStateModel: NSObject {
//    "user_id" = 1;
//    "user_name" = peterZ;
//    "user_online_status" = 0;
//    "user_picture" = hah;
    var user_id:String?
    var user_name:String?
    var user_online_status:String?
    var user_picture:String?
    
    func UserStateModelMethodWithDict(Dict dict:Dictionary<String,AnyObject>)->UserStateModel{
        
        let userstatemodel = UserStateModel()
        
        userstatemodel.user_id =  String(dict["user_id"])
        userstatemodel.user_name = String(dict["user_name"])
        userstatemodel.user_online_status = String(dict["user_online_status"])
        userstatemodel.user_picture = String(dict["user_picture"])
        
        return userstatemodel
    }
    
}
