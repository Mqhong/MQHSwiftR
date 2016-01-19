//
//  UserModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class UserModel: NSObject {
    var login_msg:String?
    var login_result:String?
    var upload_token:String?
    var user_id:String?
    var user_name:String?
    var user_picture:String?
//    var text:String?
    
    func UserModelMethod(Dict dict:Dictionary<String,AnyObject>)->UserModel{
        
        let user:UserModel = UserModel()
        user.login_result = String(dict["login_result"]!)
        user.user_id =  dict["user_id"] as? String
        user.user_picture = dict["user_picture"] as? String
        user.login_msg = dict["login_msg"] as? String
        user.user_name = dict["user_name"] as? String
        user.upload_token = dict["upload_token"] as? String
        
        return user

    }
    
    
}
