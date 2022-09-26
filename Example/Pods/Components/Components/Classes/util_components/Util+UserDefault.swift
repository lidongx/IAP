//
//  UserDefault.swift
//  OOG104
//
//  Created by lidong on 2019/7/17.
//  Copyright © 2019 maning. All rights reserved.
//

import UIKit


//是否UserDefault exist key
public func userExistKey(key: String) -> Bool {
    let defaults = UserDefaults.standard
    let dict =  defaults.dictionaryRepresentation()
    return dict.keys.contains(key)
}

//UserDefault 获取bool value
public func userGetBool(key: String) -> Bool {
    let defaults = UserDefaults.standard
    let value = defaults.bool(forKey: key)
    return value
}

//UserDefault 获取bool value
public func userGetBool(key: String, defaultValue:Bool = false) -> Bool {
    let defaults = UserDefaults.standard
    let dict =  defaults.dictionaryRepresentation()
    if !dict.keys.contains(key){
        return defaultValue
    }
    let value = defaults.bool(forKey: key)
    return value
}

//UserDefault 获取int value
public func userGetInt(key: String) -> Int {
    let defaults = UserDefaults.standard
    let value = defaults.integer(forKey: key)
    return value
}

//UserDefault 获取int value
public func userGetInt(key: String,defaultValue:Int) -> Int {
    let defaults = UserDefaults.standard
    let dict =  defaults.dictionaryRepresentation()
    if !dict.keys.contains(key){
        return defaultValue
    }
    let value = defaults.integer(forKey: key)
    return value
}

//UserDefault 获取[int] value
public func userGetIntArray(key: String)->[Int]{
    let defaults = UserDefaults.standard
    let array = defaults.array(forKey: key) as? [Int] ?? [Int]()
    return array
}

//UserDefault 保存[int] value
public func userSetIntArray(key:String,value:[Int]){
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
}

//UserDefault 获取数组 value
public func userGetArr(key: String) -> [Any]? {
    let defaults = UserDefaults.standard
    let value = defaults.array(forKey: key)
    return value
}

//UserDefault 保存数组 value
public func userSaveArr(key: String, value: [Any], isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)    
}

//UserDefault 获取Float
public func userGetFloat(key: String) -> Float {
    let defaults = UserDefaults.standard
    let value = defaults.float(forKey: key)
    return value
}

//UserDefault 获取Float
public func userGetFloat(key: String,defaultValue:Float) -> Float {
    let defaults = UserDefaults.standard
    let dict =  defaults.dictionaryRepresentation()
    if !dict.keys.contains(key){
        return defaultValue
    }
    let value = defaults.float(forKey: key)
    return value
}

//UserDefault 获取Double
public func userGetDouble(key: String) -> Double {
    let defaults = UserDefaults.standard
    let value = defaults.double(forKey: key)
    return value
}

//UserDefault 获取字符串
public func userGetString(key: String,defaultValue:String) -> String? {
    let defaults = UserDefaults.standard
    let dict =  defaults.dictionaryRepresentation()
    if !dict.keys.contains(key){
        return defaultValue
    }
    let value = defaults.string(forKey: key)
    return value
}

//UserDefault 获取字符串
public func userGetString(key: String) -> String? {
    let defaults = UserDefaults.standard
    let value = defaults.string(forKey: key)
    return value
}

//重置userdefault
private func userSaveEnd(isAnsy: Bool) {
    let defaults = UserDefaults.standard
    if isAnsy {
        defaults.synchronize()
    } else {
        UserDefaults.resetStandardUserDefaults()
    }
}

//UserDefault 保存
public func userSave(key: String, value: Any, isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)
}

//UserDefault 保存Int
public func userSaveInt(key: String, value: Int, isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)
}

//UserDefault 保存Float
public func userSaveFloat(key: String, value: Float, isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)
}

//UserDefault 保存Double
public func userSaveDouble(key: String, value: Double, isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)
}

//UserDefault 保存字符串
public func userSaveString(key: String, value: String, isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)
}

//UserDefault 保存Bool
public func userSaveBool(key: String, value: Bool, isAnsy: Bool = true) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    userSaveEnd(isAnsy: isAnsy)
}

