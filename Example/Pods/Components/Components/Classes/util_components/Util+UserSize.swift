//
//  UserSize.swift
//  OOG104
//
//
//  c 是 convert 的缩写。 r 是  real 的缩写
//
//  Created by lidong on 2019/7/17.
//  Copyright © 2019 maning. All rights reserved.
//

import UIKit

public func userSize<T>(_ width:T,_ height:T) -> CGSize{
    return CGSize(width: real(width), height: real(height))
}

public func rIphoneX(_ x1:CGFloat, _ x2:CGFloat) -> CGFloat {
    if(isIphoneX()){
        return x1
    }
    return x2
}

public func cIphoneX(_ x1:CGFloat, _ x2:CGFloat) -> CGFloat {
    if(isIphoneX()){
        return cX(x1)
    }
    return cX(x2)
}
//真实坐标
public func rIpad(_ x1:CGFloat, _ x2:CGFloat) -> CGFloat {
    if(isPad()){
        return x1
    }
    return x2
}

public func rIpad(_ x1:CGFloat, _ x2:CGFloat,_ x3:CGFloat) -> CGFloat {
    if(isPad()){
        return x1
    }
    
    if isIphoneX(){
        return x2
    }
    
    return x3
}


// convert 适配坐标
public func cIpad(_ x1:CGFloat, _ x2:CGFloat) -> CGFloat {
    if(isPad()){
        return cX(x1)
    }
    return cX(x2)
}

public func cIpad(_ x1:CGFloat, _ x2:CGFloat,_ x3:CGFloat) -> CGFloat {
    if(isPad()){
        return cX(x1)
    }
    
    if isIphoneX(){
        return cX(x2)
    }
    
    return cX(x3)
}

public func rRect(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat)->CGRect{
    return CGRect(x: x, y: y, width: width, height:height)
}

public func cRect(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat)->CGRect{
    return CGRect(x: cX(x), y: cX(y), width: cX(width), height:cX(height))
}

public func cFrameWidth(view:UIView,width:CGFloat) -> CGFloat {
    return width * view.frame.size.width / rIpad(768.0, 375.0)
}

public func convertX<T>(_ value:T)->CGFloat{
    return cX(value)
}

public func convertY<T>(_ value:T)->CGFloat{
    return cY(value)
}

public class Iphone7 {
    public static func convertPadding<T>(_ value:T)->CGFloat{
        return cX(value)
    }

    public static func covertMargin<T>(_ value:T)->CGFloat{
        return cX(value)
    }

    public static func covertHeight<T>(_ value:T)->CGFloat{
        return cX(value)
    }

    static func covertWidth<T>(_ value:T)->CGFloat{
        return cX(value)
    }
    
    public static func covertDynamicPadding<T>(_ value:T)->CGFloat{
        return cY(value)
    }
    
    public static func covertDynamicMargin<T>(_ value:T)->CGFloat{
        return cY(value)
    }
    
    public static func covertDynamicWidth<T>(_ value:T)->CGFloat{
        return cX(value)
    }
    
    public static func covertDynamicHeight<T>(_ value:T)->CGFloat{
        return cY(value)
    }
}

public class IphoneX {
    
    public static func convertPadding<T>(_ value:T)->CGFloat{
        return cX(value)
    }
    
    public static func covertMargin<T>(_ value:T)->CGFloat{
        return cX(value)
    }
    
    public static func covertHeight<T>(_ value:T)->CGFloat{
        return cX(value)
    }

    public static func covertWidth<T>(_ value:T)->CGFloat{
        return cX(value)
    }
    
    public static func covertDynamicPadding<T>(_ value:T)->CGFloat{
        return cY2(value)
    }
    
    public static func covertDynamicMargin<T>(_ value:T)->CGFloat{
        return cY2(value)
    }
    
    public static func covertDynamicWidth<T>(_ value:T)->CGFloat{
        return cX(value)
    }
    
    public static func covertDynamicHeight<T>(_ value:T)->CGFloat{
        return cY2(value)
    }
    
}

public func valueForConvert<T>(_ ipad:T,_ iphone:T)->CGFloat{
    if isPad(){
        return cX(ipad)
    }
    return cX(iphone)
}

public func valueForConvert<T>(_ ipad:T,_ iphoneX:T,_ iphone7:T)->CGFloat{
    if isPad(){
        return cX(ipad)
    }
    else if isIphoneX(){
        return cX(iphoneX)
    }
    return cX(iphone7)
}

public func valueForReal<T>(_ ipad:T,_ iphone:T)->CGFloat{
    if isPad(){
        return real(ipad)
    }
    return real(iphone)
}

public func valueForReal<T>(_ ipad:T,_ iphoneX:T,_ iphone7:T)->CGFloat{
    if isPad(){
        return real(ipad)
    }
    else if isIphoneX(){
        return real(iphoneX)
    }
    return real(iphone7)
}
