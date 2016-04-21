//
//  UserModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class UserModel: NSObject {
   public var login_msg:String?
   public var login_result:String?
   public var upload_token:String?
   public var user_id:String?
   public var user_name:String?
   public var user_picture:String?
//    var text:String?
    
    func UserModelMethod(Dict dict:Dictionary<String,AnyObject>)->UserModel{
        
        let user:UserModel = UserModel()
        user.login_result = self.Diction_Str(dict, keystr: "login_result")
        user.user_id =  self.Diction_Str(dict, keystr: "user_id")
        user.user_picture =  self.Diction_Str(dict, keystr: "user_picture")
        user.login_msg = self.Diction_Str(dict, keystr: "login_msg")
        user.user_name = self.Diction_Str(dict, keystr: "user_name")
        user.upload_token = self.Diction_Str(dict, keystr: "upload_token")
        return user

    }
    
    private func Diction_Str(dict:AnyObject,keystr:String)->String{
        let str = dict[keystr]!
        return String(str!)
    }
    
}
