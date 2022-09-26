//
//  Util+Date+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/5/31.
//

import Foundation



public extension Date{
    
    //时间戳 秒
    var timeStamp:Int{
        return Int(self.timeIntervalSince1970)
    }

    /// 获取当前 秒级 时间戳 - 10位
    var timeStampString: String {
        return "\(self.timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliTimeStampString: String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
    //通过组建数组获取日期组建对象
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    
    /// 日历组件获取组件值
    /// - Parameters:
    ///   - component: 日历组件
    ///   - calendar: 日历
    /// - Returns: 组件值
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    
    /// 日历组件数组获取组件值
    /// - Parameters:
    ///   - components: 日历组件数组
    ///   - calendar: 日历
    /// - Returns: 组件值数组
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> [Int]{
        var values = [Int]()
        components.forEach { component in
            values.append(get(component))
        }
        return values
    }
    
    //date的年数
    var year:Int {
        return get(.year)
    }
    
    //date的月数
    var month:Int {
        return get(.month)
    }
    
    //date的天数
    var day:Int {
        return get(.day)
    }
    
    //date的小时数
    var hour:Int {
        return get(.hour)
    }
    
    //date的分钟数
    var minute:Int {
        return get(.minute)
    }
    
    //date的秒数
    var second:Int {
        return get(.second)
    }

    //获取年月日
    var yearMonthDay:[Int]{
        return get(.year,.month,.day)
    }
    
    //获取星期几 值为1～7 星期天为1 星期六为7
    var weekday:Int{
        return get(.weekday)
    }
    
    
    /// 调整一个时间组件修改时间
    /// - Parameters:
    ///   - component: 日历组件
    ///   - value: 日历组件值
    /// - Returns: 修改日历组件后的时间
    func adjust(_ component: Calendar.Component,_ value:Int)->Date?{
        var dateComponents = Calendar.current.dateComponents(in: .current, from: self)
        dateComponents.setValue(value, for: component)
        return Calendar.current.date(from: dateComponents)
    }
    
    
    /// 通过日历组件修改时间
    /// - Parameters:
    ///   - components: 日历组件数组
    ///   - values: 组件值
    /// - Returns: 修改日历组件后的时间
    func adjust(_ components:[Calendar.Component],_ values:[Int])->Date?{
        if components.count != values.count{
            assert(false,"数组不对应")
            return nil
        }
        var dateComponents = Calendar.current.dateComponents(in: .current, from: self)
        for (index,component) in components.enumerated(){
            dateComponents.setValue(values[index], for: component)
        }
        return Calendar.current.date(from: dateComponents)
    }
    
    /// 修改日期的年月日
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    /// - Returns: 修改年月日之后的时间
    func adjust(year:Int,month:Int,day:Int)->Date?{
        return adjust([.year,.month,.day], [year,month,day])
    }
    
    /// 修改日期的时分秒
    /// - Parameters:
    ///   - hour: 时
    ///   - minute: 分
    ///   - second: 秒
    /// - Returns: 修改时分秒之后的时间
    func adjust(hour:Int,minute:Int,second:Int)->Date?{
        return adjust([.hour,.minute,.second], [hour,minute,second])
    }
    
    //是否是星期一
    var isMonday:Bool {
        return get(.weekday) == 2
    }

    //是否是星期六
    var isSatday:Bool {
        return get(.weekday) == 7
    }

    //是否是星期天
    var isSunday:Bool {
        return get(.weekday) == 1
    }
}



/*
Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
09/12/2018                        --> MM/dd/yyyy
09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
Sep 12, 2:11 PM                   --> MMM d, h:mm a
September 2018                    --> MMMM yyyy
Sep 12, 2018                      --> MMM d, yyyy
Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
12.09.18                          --> dd.MM.yy
10:41:02.112                      --> HH:mm:ss.SSS
*/


/// 常见的时间格式
public enum DateFormat: String {
    case EEEEMMMdyyyy = "EEEE, MMM d, yyyy"// Wednesday, Sep 12, 2018
    case EEEMMMMd = "EEEE, MMM d"  //Wednesday, Sep 12
    case EEEE = "EEEE"             //Wednesday
    case MMMMdYYYY = "MMMM d, YYYY"  //September 12, 2018
    case YYYYMMddHHmmss = "YYYY-MM-dd HH:mm:ss" //2018-09-12 14:11:05
    case yyyyMMdd = "yyyy-MM-dd"   //2018-09-12
    case HHmmss = "HH:mm:ss"   //14:11:05
    case EEEdMMM = "EEE, d MMM"   //Sep, 1 2022
    //主要用于数据库时间格式datetime
    case MMMMddYYYYWithTime = "MMMM dd, yyyy 'at' h:mm a"
    case DateWithTimeZone = "yyyy-MM-dd'T'HH:mm:Ss.SSSZ" //2018-09-12T14:11:54+0000  Time zone date
    case HHmmssSSS = "HH:mm:ss.SSS"   //10:41:02.112
    case UTC = "yyyy-MM-dd'T'HH:mm:ssZ"
    case MMddyyyy = "MM/dd/yyyy"  //MM/dd/yyyy
}

public extension Date{
    
    /// 通过时间格式获取字符串
    /// - Parameter format: 时间格式
    /// - Returns:获取的时间格式字符串
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_GB")
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    
    /// 将日期转换为字符串
    /// - Parameter format: 日期格式
    /// - Returns: 日期字符串
    func string(_ format: DateFormat) -> String {
        return string(format.rawValue)
    }
    
    /// 获取年月日字符串
    /// - Returns: 年月日字符串
    var yearMonthDayString:String{
        return string(DateFormat.yyyyMMdd)
    }
    
    /// 获取年月日时分秒字符串
    /// - Returns: 年月日时分秒字符串
    var fullTimeString:String{
        return string(DateFormat.YYYYMMddHHmmss)
    }
    
    
}
