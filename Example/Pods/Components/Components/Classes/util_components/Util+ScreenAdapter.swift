//
//  ScreenAdapter.swift
//  OOG104
//
//  Created by lidong on 2021/6/25.
//  Copyright © 2021 maning. All rights reserved.
//

import UIKit


public func appWindow() ->UIWindow{
    return UIApplication.shared.windows[0]
}

public func isIphoneX() -> Bool {
    var isiPhoneX: Bool = false
    if UIDevice.current.userInterfaceIdiom == .phone {
        let height = UIScreen.main.nativeBounds.size.height
        let width = UIScreen.main.nativeBounds.size.width
        var ratio: CGFloat = 0
        if height > width {
            ratio = height / width
        } else {
            ratio = width / height
        }
        if ratio >= 2.1, ratio < 2.3 {
            isiPhoneX = true
        }
    }
    return isiPhoneX
}

public func isPad() -> Bool {
    return (UIDevice.current.userInterfaceIdiom == .pad) ? true : false
}

public func isThreeCX(_ ipad: CGFloat, _ iphoneX: CGFloat, _ other: CGFloat) -> CGFloat {
    isPad() ? cX(ipad) : isIphoneX() ? cX(iphoneX) : cX(other)
}


public func fullScreenBounds() -> CGRect {
    //return UIScreen.main.bounds
    //解决屏幕旋转问题
    return CGRect(x: 0, y: 0, width: min(UIScreen.main.bounds.width,UIScreen.main.bounds.height), height: max(UIScreen.main.bounds.width,UIScreen.main.bounds.height))
}

public func fullScreenWidth() -> CGFloat {
    return fullScreenBounds().size.width
}

public func fullScreenHeight() -> CGFloat {
    return fullScreenBounds().size.height
}

public func getWidth(view: UIView) -> CGFloat {
    return view.frame.size.width
}

public func getHeight(view: UIView) -> CGFloat {
    return view.frame.size.height
}

public func setWidth(view: UIView, width: CGFloat) {
    let frame = view.frame
    view.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.size.height)
}

public func setHeight(view: UIView, height: CGFloat) {
    let frame = view.frame
    view.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
}

public func convertWidth(_ x: CGFloat) -> CGFloat {
    return (x / (isPad() ? 768.0 : 375.0)) * fullScreenWidth()
}

public func convertHeight(_ y: CGFloat) -> CGFloat {
     return (y / (isPad() ? 1024.0 : 667.0)) * fullScreenHeight()
}

public func convertViewWidth(view: UIView, width: CGFloat) -> CGFloat {
    return width * getWidth(view: view) / (isPad() ? 768.0 : 375.0)
}

public func convertFont(fontsize: CGFloat) -> CGFloat {
    return fontsize * fullScreenWidth() / (isPad() ? 768.0 : 375.0)
}

public func real<T>(_ value:T)->CGFloat{
    if value is Int{
        let newValue = value as! Int
        return CGFloat(newValue)
    }
    if value is CGFloat{
        let newValue = value as! CGFloat
        return newValue
    }
    if value is Float{
        let newValue = value as! Float
        return CGFloat(newValue)
    }
    if value is Double{
        let newValue = value as! Double
        return CGFloat(newValue)
    }
    assert(false)
    return 0.0
}


public func cX<T>(_ value:T)->CGFloat{
    if value is Int{
        let newValue = value as! Int
        return convertWidth(CGFloat(newValue))
    }
    if value is CGFloat{
        let newValue = value as! CGFloat
        return convertWidth(newValue)
    }
    if value is Float{
        let newValue = value as! Float
        return convertWidth(CGFloat(newValue))
    }
    if value is Double{
        let newValue = value as! Double
        return convertWidth(CGFloat(newValue))
    }
    assert(false)
    return 0.0
}

public func cY<T>(_ value:T) -> CGFloat{
    if value is Int{
        let newValue = value as! Int
        return convertHeight(CGFloat(newValue))
    }
    if value is CGFloat{
        let newValue = value as! CGFloat
        return convertHeight(newValue)
    }
    if value is Float{
        let newValue = value as! Float
        return convertHeight(CGFloat(newValue))
    }
    if value is Double{
        let newValue = value as! Double
        return convertHeight(CGFloat(newValue))
    }
    assert(false)
    return 0.0
}

//iphoneX 转换为 iphone7的适配方案
//也即IphoneX的适配方案
public func cY2<T>(_ value:T) -> CGFloat{
    if value is Int{
        let newValue = value as! Int
        return cY(CGFloat(newValue) * 667.0/812.0)
    }
    if value is CGFloat{
        let newValue = value as! CGFloat
        return cY(CGFloat(newValue) * 667.0/812.0)
    }
    if value is Float{
        let newValue = value as! Float
        return cY(CGFloat(newValue) * 667.0/812.0)
    }
    if value is Double{
        let newValue = value as! Double
        return cY(CGFloat(newValue) * 667.0/812.0)
    }
    assert(false)
    return 0.0
}


