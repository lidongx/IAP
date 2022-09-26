//
//  Util+String+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/5/31.
//

import Foundation

// String 是文件路径 获取路径文件内容
public extension String{
    
    var content:String?{
        do {
            let jsonString = try String(contentsOfFile: self, encoding: String.Encoding.utf8)
            return jsonString
        }catch{
            return nil
        }
    }
    
    var contentData:Data?{
        do {
            return try Data(contentsOf: URL(fileURLWithPath: self))
        } catch {
            return nil
        }
    }
    
    var url:URL{
        return URL(fileURLWithPath: self)
    }
}

public extension String{
    ///计算字符串的宽度
    func width(_ font: UIFont) -> CGFloat {
        (self as NSString).boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil).width
    }
    
    /// 计算字符串的高度
    /// - Parameters:
    ///   - width: 需要显示的宽度
    ///   - font: 显示的字体
    /// - Returns: 计算的显示的高度
    func height(_ width: CGFloat, _ font: UIFont) -> CGFloat {
        (self as NSString).boundingRect(with: CGSize.init(width: width, height:  CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil).height
    }
}

//字符串为图片名。获取图片
public extension String{
    var image:UIImage?{
        return UIImage(named: self)
    }
}

//计算属性
public extension String{
  
    
    /// Return same string withot whitespaces or newlines
    var trimed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    ///是否包含表情
    var isContainsEmoji: Bool{
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// Return true if the string matched an email format like "cs.alhaider@gmail.com"
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // This is a regular expression
        return self.matches(emailFormat)
    }
    
    /// Return true if the string has only numbers "0123456789".
    var isValidNumber: Bool {
        let numberFormat = "^[0-9]*$"
        return self.matches(numberFormat)
    }
    
    ///是否是数字和字母的组合
    var isValidNumberAndLetters:Bool{
        let reg = "^[a-zA-Z0-9]+$"
        return self.matches(reg)
    }
    
    /// Return true if the string has minimum 8 characters, and at least one uppercase letter, and one lowercase letter and one number
    /// , You can see more on http://regexlib.com/Search.aspx?k=password
    var isValidPassword: Bool {
        let passwordFormat = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        return self.matches(passwordFormat)
    }
    
    /// Validating a string whether it is hexadecimal color or not using regular expression
    var isValidHex: Bool {
        let hexadecimalFormat = "^#(?:[0-9a-fA-F]{3}){1,2}$"
        return self.matches(hexadecimalFormat)
    }
    
    /// Return true if the string is a valid url
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// 正则匹配
    /// - Parameter regex: regular expression
    /// - Returns: true if matches the given regex
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    func removeSpecialCharacters()->String{
        //去除表情规则
        //  \u0020-\\u007E  标点符号，大小写字母，数字
        //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
        //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
        //  \uF900-\\uFAFF  部分汉字
        //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
        //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
        //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
        // 注：对照表 http://blog.csdn.net/hherima/article/details/9045765
        // 用法注释：https://www.jianshu.com/p/9ab8b70b173f
        //let expression = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]"
        
        //去除特殊字符
        let pattern: String = "[^&a-zA-Z0-9\u{4e00}-\u{9fa5}\\s]"//"\s"匹配空格
        let express = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return express.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: "")
    }
    
    //打印输出
    func log(){
        print(self)
    }
}


public extension String{
    
    ///字符串转换为颜色
    ///支持格式 ///"#4DA2D9","#4DA2D9CC","0x4DA2D9"
    var color:UIColor?{
        if isValidHex{ //只支持"#4DA2D9","#4DA2D9CC"
            return UIColor(hexString: self)
        }
        return nil
    }
    
    //字符串转float
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    //字符串转字典对象
    var json:[String:Any]?{
        if let jsonData = self.data(using: String.Encoding.utf8, allowLossyConversion: false){
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            return json as? [String:Any]
        }
        return nil
    }
 
    //字符串转换为Data
    var data:Data?{
        return self.data(using: .utf8)
    }
    
    var date:Date?{
        return date()
    }
    
    //字符串转换为时间
    func date(_ format:DateFormat = .YYYYMMddHHmmss)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_GB")
        return dateFormatter.date(from: self)
    }
    
    ///转换为CGFloat
    var cgFloat: CGFloat {
        get {
            CGFloat(Double(self) ?? 0)
        }
    }
    
    ///根据URL字符串获取youtube id
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        return (self as NSString).substring(with: result.range) as String
    }
}

///子字符串
extension String{
    
    /// 从开始到固定index的子字符串
    /// - Parameter index: 结束index
    /// - Returns: 子字符串
    func subString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    ///  从固定index开始到结尾的子字符串
    /// - Parameter index: start index
    /// - Returns: 子字符串
    func subString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    
    
    /// 替换字符串
    /// - Parameters:
    ///   - target: 被替换的字符串
    ///   - replacedString: 用该字符串替换
    /// - Returns: 替换结果
    func replace(_ target: String, with replacedString: String) -> String {
        return self.replacingOccurrences(of: target, with: replacedString, options: NSString.CompareOptions.literal, range: nil)
    }

    /// 返回子字符串的位置
    /// - Parameters:
    ///   - sub: 子字符串
    ///   - backwards: true:最后出现的位置  false 开始出现的位置
    /// - Returns: 位置
    func indexOf(_ sub:String, _ backwards:Bool = false) ->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}


public extension String{
    @discardableResult
    ///  首尾去掉空格
    /// - Returns: 剪辑的字符串
    mutating func trim() -> String {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return self
    }
    
    ///url增加path
    func appendingPathComponent(_ str: String) -> String {
         return (self as NSString).appendingPathComponent(str)
    }
    
    //url字符串增加参数
    func addingURLQueryParameters(_ params: [String: String]) -> String? {
        return URL(string: self)?.addingQueryParameters(params).path
    }
    
    /// 获取字符串查询字典
    var queryParameters: [String: String]? {
        return URL(string: self)?.queryParameters
    }

}


///字符串Attribute 扩展
public extension String {
    var attributed: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}


public extension String{
    //字符串转换为ViewController
    var viewController:UIViewController?{
        guard let viewController: UIViewController.Type = toClass() else {
            return nil
        }
        return viewController.init()
    }

    //字符串转换为类
    func toClass<T>()->T.Type?{
       //let name =  objc_getClass(self)
       // print(name)
        if self.contains("."){
            guard let aClass = NSClassFromString(self) as? T.Type else {
                return nil
            }
            return aClass
        }else{
            guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String, let aClass = NSClassFromString("\(nameSpace).\(self)") as? T.Type else {
                return nil
            }
            return aClass
        }
    }
}


