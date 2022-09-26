//
//  Util+Data+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/7.
//

import Foundation

public extension Data {
    
    /// Data 转字符串
    /// - Parameter encoding: 编码方式
    /// - Returns: 字符串
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    //Data 转Utf8 字符串
    var utf8String:String{
        return string(encoding: .utf8) ?? ""
    }
    
    //Data 转换为字典
    var dict:[String:Any]?{
        return self.utf8String.json
    }
    
    var json:[String:Any]?{
        return dict
    }
    
    //获取字节数组
    var bytes: [UInt8] {
        return [UInt8](self)
    }

    //16进制字符串
    var hex: String {
        return self.bytes.toHexString()
    }
    
    func toHexString(_ separator: String = "") -> String {
        return self.bytes.toHexString(separator)
    }
    
    //转换为Model
    func decode<T: Decodable>(_ type: T.Type) -> T {
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: self) else {
            fatalError("Failed to decode \(self)")
        }
        return loaded
    }

}
