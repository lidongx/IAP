//
//  Util+Int+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/5/31.
//

import Foundation

///时间的秒数
public extension Int{
    
    //转换为字符串
    var string:String{
        return "\(self)"
    }
    
    //转换为CGFloat
    var cgFloat:CGFloat{
        return CGFloat(self)
    }
    
    ///获取分钟秒字符串
    var msTime:String {
        let minute: Int = self / 60
        let minuteString: String =  String.init(format: "%02d", minute)
        let second = self % 60
        let secondString: String = String.init(format: "%02d", second)
        return "\(minuteString):\(secondString)"
    }
    
    ///小时分钟秒字符串
    var hmsTime:String{
        let hour = self / 3600
        let hourString = String.init(format: "%02d", hour)
        
        let offset = self % 3600
        let minute: Int = offset / 60
        
        let minuteString: String = String.init(format: "%02d", minute)
        let second = offset % 60
        let secondString: String = String.init(format: "%02d", second)
        return "\(hourString):\(minuteString):\(secondString)"
    }
    
    //小时分钟字符串
    var hmTime:String{
        let hour = self / 3600
        let hourString = String.init(format: "%02d", hour)
        
        let offset = self % 3600
        let minute: Int = offset / 60
        let minuteString: String = String.init(format: "%02d", minute)

        return "\(hourString):\(minuteString)"
    }
    
    //转换为时间
    var date:Date?{
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    //转换为color  0x4DA2D9 self 16进制
    var color:UIColor{
        return UIColor(hexInt: self)
    }
    
    
}
