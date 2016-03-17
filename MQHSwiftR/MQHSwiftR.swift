//
//  MQHSwiftR.swift
//  ChatDemo
//
//  Created by mm on 16/1/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SwiftR

@objc public protocol MQHSwiftRDelegate{
    /**!
     登录成功的回调
     
     :param: Dict 服务器返回的数据
     */
    optional func MQHSwiftR_LoginCallBack(request:AnyObject?)
    /**
     获取目标信息回调
     
     :param: request chat_session_id 聊天会话 id target_id 目标id target_name 目标名称 target_picture 目标头像
     */
    optional func MQHSwiftR_ReceiveTargetInfo(request:AnyObject?)
    /**
     获取用户会话列表的回调
     
     :param: request
     {
     chat_session_id //聊天会话 id
     chat_session_type //聊天会话类型 0:用户 1:群
     message_count //会话未读消息条数
     last_sender_id //最后发送者 id
     last_message //最后条消息
     last_message_time //最后条消息发送时间
     为1是群id
     last_message_type //最后条消息类型
     target_id //会话目标 id ,会话类型为 0 是用户 id,
     target_name //
     目标名称 目标头像
     target_picture //
     target_online_status //目标在线状态(仅用于 chat_session_type 为用户时)
     },
     */
    optional func MQHSwiftR_ReceiveChatSessionList(request:AnyObject?)
    
    /**
     获取用户未读信息回调
     
     :param: request {
     chat_session_id //聊天会话 id
     chat_session_type //聊天会话类型 0:用户 1:群
     sender_id //最后发送者 id
     message_id //消息 id
     message //消息内容
     message_time //消息发送时间
     message_type //消息类型
     },
     {
     ```
     },
     */
    optional func MQHSwiftR_ReceiveUnreadMessages(request:AnyObject?)
    
    
    /**
     获取用户历史消息回调
     
     :param: request ddd
     [
     chat_session_id //聊天会话 id
     history_messages:
     {
     chat_session_id //聊天会话 id
     chat_session_type //聊天会话类型 0:用户 1:群
     sender_id //发送者 id
     message_id //消息id
     message //消息内容
     message_time //消息发送时间
     message_type //消息类型
     },
     
     unread_messages:{
     ...... //同上
     } ]
     */
    optional func MQHSwiftR_ReceiveHistoryMessages(request:AnyObject?)
    
    /**
     发送消息的回调
     
     :param: request
     {
     chat_session_id //聊天会话 id
     chat_session_type //聊天会话类型 0:用户 1:群
     sender_id //最后发送者 id
     message_id //消息 id
     message //消息内容
     message_time //消息发送时间
     // token message_type //消息类型
     }
     */
    optional func MQHSwiftR_MessageCallback(request:AnyObject?)
    
    
    /**
     接收消息
     
     :param: request
     {
     chat_session_id //聊天会话 id
     chat_session_type //聊天会话类型 0:用户 1:群
     sender_id //发送者 id
     message_id //消息 id
     message //消息内容
     message_time //消息发送时间
     message_type //消息类型
     }
     */
    optional func MQHSwiftR_ReceiveMessage(request:AnyObject?)
    
    /**
     聊天用户(对方)在线状态改变
     
     :param: request
     {
     user_id //用户 id
     user_name //用户名称
     user_picture //用户图片
     user_onli  //在线状态 0:离线 1:在线
     }
     */
    optional func MQHSwiftR_ChatUserStatusChanged(request:AnyObject?)
    
    
    /**
     用户断开连接或重链接
     
     :param: request
     返回的改变后的状态
     
     */
    optional func BreakOrConnectTheConnection(request:AnyObject?)
    
    
}



public enum MQHSwiftRState{
    case Connecting
    case Connected
    case Disconnected
}


public class MQHSwiftR: NSObject {

    public weak var delegate : MQHSwiftRDelegate?
    var MQHSwiftRDaostate:MQHSwiftRState!
    var chatHub:Hub!
    var hubConnection:SignalR!
    
    
    //通知的名称
    let Knotice_receiveMessage:String = "receiveMessage"//接收到消息的通知
    
    
    
    /**
     初始化连接池，并监听回调
     */
  public  func _initMQHSwiftR(urlStr urlStr:String){
        
        hubConnection = SwiftR.connect(urlStr) { [weak self] connection in
            
            self?.chatHub = connection.createHubProxy("chatHub")

            //MARK:监听loginCallback方法
            self?.chatHub.on("loginCallback", callback: { (args) -> () in
//                print("接收到loginCallback回调方法")
                
                var user:UserModel = UserModel()
                
                let dict:Dictionary<String,AnyObject>! = args?["0"] as? Dictionary
                
                user = user.UserModelMethod(Dict: dict)
                
                self?.delegate?.MQHSwiftR_LoginCallBack!(user)
                
            })
            
            //MARK:监听获取目标信息
            self?.chatHub.on("receiveTargetInfo", callback: { (args) -> () in
                print("接收到获取目标信息")
                
                var mmtargetmodel:TargetUserModel = TargetUserModel()
                
                let dict:Dictionary<String,AnyObject>! = args?["0"] as? Dictionary
                
                mmtargetmodel =  mmtargetmodel.TargetUserModelMethod(Dict: dict)
                
                self?.delegate?.MQHSwiftR_ReceiveTargetInfo!(mmtargetmodel)
            })
            
            //MARK:监听获取用户会话列表
            self?.chatHub.on("receiveChatSessionList", callback: { (args) -> () in
                print("接收到用户会话列表")
                
                let Arrdict:Array<AnyObject>! = args?["0"] as? Array
                
                let sessionlistmodel = SessionListModel()
                
                let sessionmodel = SessionModel()
                
                sessionlistmodel.SessionList = sessionmodel.SessionListModelMethod(ArrDict: Arrdict)
                
                self?.delegate?.MQHSwiftR_ReceiveChatSessionList!(sessionlistmodel)
                
            })
            
            
            //MARK:监听获取用户未读消息
            self?.chatHub.on("receiveUnreadMessages", callback: { (args) -> () in
                print("接收到用户未读消息")
                
                let ArrDict:Array<AnyObject>! = args?["0"] as? Array
                
                let message = MessageModel()
                
                let arr:Array<MessageModel> = message.MessageModelMethodWithArrDict(ArrDict: ArrDict)
                
                let unreadMessages:UnreadMessagesModel = UnreadMessagesModel()
                
                unreadMessages.unread_messages = arr;
                
//                print("arr:\(unreadMessages)")
                
                self?.delegate?.MQHSwiftR_ReceiveUnreadMessages!(unreadMessages)
            })
            
            //MARK:监听获取用户历史消息
            self?.chatHub.on("receiveHistoryMessages", callback: { (args) -> () in
                print("接收到历史消息")
                
                let TotelDict:Dictionary<String,AnyObject>! = args?["0"] as? Dictionary
                
                
                let unread_messages:Array<AnyObject> = (TotelDict["unread_messages"] as? Array<AnyObject>)!
                
                let history_messages:Array<AnyObject> = (TotelDict["history_messages"] as? Array<AnyObject>)!
                
                let historyMessageses:HistoryMessageModel = HistoryMessageModel()
                
                let messmodel = MessageModel()
                
                historyMessageses.chat_session_id = TotelDict["chat_session_id"] as? String
                
                historyMessageses.unread_messages = messmodel.MessageModelMethodWithArrDict(ArrDict: unread_messages)
                
                historyMessageses.history_messages = messmodel.MessageModelMethodWithArrDict(ArrDict: history_messages)
                
                print(historyMessageses)
                
                self?.delegate?.MQHSwiftR_ReceiveHistoryMessages!(historyMessageses)
            })
            
            //MARK:监听发送消息的回调
            self?.chatHub.on("messageCallback", callback: { (args) -> () in
                
                print("接收到发送消息的回调")
                
                let Dict:Dictionary<String,AnyObject>! = args?["0"] as? Dictionary
                
                var messagemodel = MessageModel()
                
                messagemodel = messagemodel.MessageModelMethodWithDict(Dict: Dict)
                
                
                
                //MARK:发送一个通知---发送消息的回调
                NSNotificationCenter.defaultCenter().postNotificationName("SendMessageCallBack", object: messagemodel)
                
//                self?.delegate?.MQHSwiftR_MessageCallback!(messagemodel)
                
            })
            
            //MARK:监听接收消息
            self?.chatHub.on("receiveMessage", callback: { (args) -> () in
                
                print("接收到消息")
                
                let Dict:Dictionary<String,AnyObject>! = args?["0"] as? Dictionary
                
                var messagemodel = MessageModel()
                
                messagemodel = messagemodel.MessageModelMethodWithDict(Dict: Dict)
                
//                self?.delegate?.MQHSwiftR_ReceiveMessage!(messagemodel)
                
                //MARK:发送一个通知---接收消息的通知
                NSNotificationCenter.defaultCenter().postNotificationName("receiveMessage", object: messagemodel)
                
            })
            
            //MARK:监听聊天用户(对方)在线状态
            self?.chatHub.on("chatUserStatusChanged", callback: { (args) -> () in
                
//                print("接收到对方在线状态")
                
                var userstatemodel = UserStateModel()
                
                let Dict:Dictionary<String,AnyObject>! = args?["0"] as? Dictionary
                
                userstatemodel = userstatemodel.UserStateModelMethodWithDict(Dict: Dict)
                
                
                self?.delegate?.MQHSwiftR_ChatUserStatusChanged!(userstatemodel)
                
            })
            
            
            connection.starting = { [weak self] in
                print("Starting...")
                self!.MQHSwiftRDaostate = MQHSwiftRState.Connecting
                print("MQHSwiftRstate:\(self!.MQHSwiftRDaostate)")
                self!.delegate?.BreakOrConnectTheConnection!(String(self!.hubConnection.state))
            }
            
            connection.reconnecting = { [weak self] in
                print("Reconnecting...")
                self!.MQHSwiftRDaostate = MQHSwiftRState.Connecting
                print("MQHSwiftRstate:\(self!.MQHSwiftRDaostate)")
                self!.delegate?.BreakOrConnectTheConnection!(String(self!.hubConnection.state))
            }
            
            connection.connected = { [weak self] in
                print("Connected. Connection ID: \(connection.connectionID!)")
                self!.MQHSwiftRDaostate = MQHSwiftRState.Connected
                print("MQHSwiftRstate:\(self!.MQHSwiftRDaostate)")
                self!.delegate?.BreakOrConnectTheConnection!(String(self!.hubConnection.state))
            }
            
            connection.reconnected = { [weak self] in
                print("Reconnected. Connection ID: \(connection.connectionID!)")
                self!.MQHSwiftRDaostate = MQHSwiftRState.Connected
                print("MQHSwiftRDaostate:\(self!.MQHSwiftRDaostate)")
                self!.delegate?.BreakOrConnectTheConnection!(String(self!.hubConnection.state))
            }
            
            connection.disconnected = { [weak self] in
                print("Disconnected.")
                self!.MQHSwiftRDaostate = MQHSwiftRState.Disconnected
                self!.delegate?.BreakOrConnectTheConnection!(String(self!.hubConnection.state))
            }
            
            connection.connectionSlow = { print("Connection slow...") }
            
            connection.error = {
                error in print("Error: \(error)")
                
                if let source = error?["source"] as? String where source == "TimeoutException" {
                    print("Connection timed out. Restarting...")
                    connection.start()
                }
            }
            
        }
        
    }
    
    
    
    //MARK:断开或者重新连接
    /**
    断开或者重新连接
    */
   public func BreakOrConnectTheConnection(){
        
        let state:String = String(MQHSwiftRDaostate)
        
        print("当前状态:\(state)")
        
        switch state {
            
        case "Connecting" :
            
            print("正在连接")
            
            
        case "Connected" :
            
            //            SwiftR.stopAll()
            hubConnection.stop()
            print("已经断开连接")
            
            
        case "Disconnected" :
            
            //            SwiftR.startAll()
            hubConnection.start()
            print("已经重新连接")
            
            
        default:
            print("没有连接")
        }
        
        
    }
    
    
    //MARK:- 心跳
    /**
    心跳
    */
    public func heart(){
        chatHub.invoke("heart", arguments: [])
    }
    
    //MARK:- 确认消息
    /**
    确认消息
    
    :param: dict {
    message_id //消息 id chat_session_id//聊天会话 id
    }
    */
    public func confirmMessage(dict:Dictionary<String,String>){
        chatHub.invoke("confirmMessage", arguments: [dict])
    }
    
    //MARK:- 发送消息
    /**
    发送消息
    
    :param: dict {
    target_id //发送目标的 id
    content //发送内容
    message_token //   token,调用者随机生成 message_type //
    }
    */
    public func messageToUser(dict:Dictionary<String,String>){
        chatHub.invoke("messageToUser", arguments: [dict])
    }
    
    //MARK:- 获取用户历史消息
    /**
    获取用户历史消息
    
    :param: dict {
    chat_session_id //聊天会话 id
    size //消息条数
    before_message_id //在哪条消息之前,可选
    }
    */
    public func getHistoryMessages(dict:Dictionary<String,String>){
        chatHub.invoke("getHistoryMessages", arguments: [dict])
    }
    
    //MARK:- 获取用户未读信息
    /**
    获取用户未读信息
    
    :param: dict {
    chat_session_id //聊天会话id
    }
    */
    public func getUnreadMessages(dict:Dictionary<String,String>){
        chatHub.invoke("getUnreadMessages", arguments: [dict])
    }
    
    //MARK:- 获取用户会话列表
    /**
    获取用户会话列表
    */
    public func getChatSessionList(){
//        print("ddd")
        chatHub.invoke("getChatSessionList", arguments: nil)
    }
    
    //MARK:- 获取目标信息
    /**
    获取目标信息
    
    :param: dict {
    target_id //目标id chat_session_type //聊天会话类型 chat_session_id //聊天会话 id
    }
    */
    public func getTargetInfo(dict:Dictionary<String,String>){
        chatHub.invoke("getTargetInfo", arguments: [dict])
    }
    
    
    //MARK:- 调用服务器的登录
    /**
    调用服务器的登录
    
    :param: token 需要的参数 token
    
    :returns: 返回是否成功
    */
    public func externalLogin(token:String){
        chatHub.invoke("externalLogin", arguments: [token])
    }
    
}

