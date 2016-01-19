//
//  TargetUserModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class TargetUserModel: NSObject {
    
    var chat_session_id:String?
    var target_id:String?
    var target_name:String?
    var target_picture:String?
    
    func TargetUserModelMethod(Dict dict:Dictionary<String,AnyObject>)->TargetUserModel{
        let mmtargetmodel:TargetUserModel = TargetUserModel()
        mmtargetmodel.chat_session_id = dict["chat_session_id"] as? String
        mmtargetmodel.target_id = dict["target_id"] as? String
        mmtargetmodel.target_name = dict["target_name"] as? String
        mmtargetmodel.target_picture = dict["target_picture"] as? String
        return mmtargetmodel
        
    }
}
