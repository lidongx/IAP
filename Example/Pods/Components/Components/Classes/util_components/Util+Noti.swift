//
//  XNoti.swift
//  Example
//
//  Created by lidong on 2022/5/27.
//

import Foundation
import UIKit


public typealias NotiCallbackX = (Notification)->Void


//NotiX  支持 blcok
public class NotiX{
    public static func add(_ observer:Any,_ selector:Selector,_ notiName:String,_ object:Any? = nil){
        Noti.add(observer, selector, notiName, object)
    }
    
    public static func add(_ notiName:String,_ object:Any? = nil, _ block:NotiCallbackX? = nil){
        Noti.add(notiName, object, block)
    }
    
    public static func send(_ notiName:String, _ object:Any? = nil , _ userInfo: [AnyHashable : Any]? = nil) {
        Noti.send(notiName,  object, userInfo)
    }
    
    public static func remove(_ observer:Any){
        Noti.remove(observer)
    }
    
    public static func remove(_ observer:Any,_ notiName:String,_ object:Any? = nil){
        Noti.remove(observer, notiName,object)
    }
}


//原代码的支持
public class Noti {
    
    public static func add(_ observer:Any,_ selector:Selector,_ notiName:String,_ object:Any? = nil){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(notiName), object: object)
    }
    
    public static func add(_ notiName:String,_ object:Any? = nil, _ block:NotiCallbackX? = nil){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(notiName), object: object, queue: .main) { notification in
            block?(notification)
        }
    }
    
    public static func send(_ notiName:String, _ object:Any? = nil , _ userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(notiName), object: object, userInfo: userInfo)
    }
    
    public static func remove(_ observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
    
    public static func remove(_ observer:Any,_ notiName:String,_ object:Any? = nil){
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(notiName), object: object)
    }
    
}
