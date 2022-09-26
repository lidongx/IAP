//
//  Util+CGFloat+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation
import Darwin

public extension CGFloat{
    
    //转化为int
    var int:Int{
        return Int(floorf(Float(self)))
    }
    
    //.2f  保留两位小数点
    var dot2F:CGFloat{
        let intValue = Int(floor(Float(self*100)))
        return CGFloat(intValue)/100
    }
    
    //.1f 保留一位小数点
    var dot1F:CGFloat{
        let intValue = Int(floor(Float(self*10)))
        return CGFloat(intValue)/10
    }
    
    //四舍五入
    var round:Int{
        let value = roundf(Float(self))
        return Int(value)
    }
    
}

