//
//  TargetUserModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class TargetUserModel: NSObject {
    
   public var chat_session_id:String?
   public var target_id:String?
   public var target_name:String?
   public var target_picture:String?
    
    func TargetUserModelMethod(Dict dict:Dictionary<String,AnyObject>)->TargetUserModel{
        let mmtargetmodel:TargetUserModel = TargetUserModel()
        mmtargetmodel.chat_session_id = self.Diction_Str(dict, keystr: "chat_session_id")
        mmtargetmodel.target_id = self.Diction_Str(dict, keystr: "target_id")
        mmtargetmodel.target_name = self.Diction_Str(dict, keystr: "target_name")
        mmtargetmodel.target_picture = self.Diction_Str(dict, keystr: "target_picture")
        return mmtargetmodel
    }
    
    private func Diction_Str(dict:AnyObject,keystr:String)->String{
        let str = dict[keystr]!
        return String(str!)
    }
}
