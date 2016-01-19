//
//  HistoryMessageModel.swift
//  ChatDemo
//
//  Created by mm on 16/1/13.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

public class HistoryMessageModel: NSObject {
    public var chat_session_id:String?
    public var history_messages:Array<MessageModel> = Array()
    public var unread_messages:Array<MessageModel> = Array()
}
