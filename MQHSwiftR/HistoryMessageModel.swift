//
//  HistoryMessageModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class HistoryMessageModel: NSObject {
    var chat_session_id:String?
    var history_messages:Array<MessageModel> = Array()
    var unread_messages:Array<MessageModel> = Array()
}
