//
//  Util+Float+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/14.
//

import Foundation

public extension Float{
    
    //转化为int
    var int:Int{
        return Int(floorf(self))
    }
    
    //.2f  保留两位小数点
    var dot2F:Float{
        let intValue = Int(floor(Float(self*100)))
        return Float(intValue)/100
    }
    
    //.1f 保留一位小数点
    var dot1F:Float{
        let intValue = Int(floor(Float(self*10)))
        return Float(intValue)/10
    }
    
    //四舍五入
    var round:Int{
        let value = roundf(Float(self))
        return Int(value)
    }
    
    //转换为CGFloat
    var cgFloat:CGFloat{
        return CGFloat(self)
    }
    
}
