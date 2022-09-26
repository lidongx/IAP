//
//  FontHelp.swift
//  OOG301
//
//  Created by mac on 2021/7/1.
//

import Foundation
import CoreFoundation
import UIKit

public enum OOGFontType : Hashable {
    
    private static var fontMap = [OOGFontType:String]()
    
    case extraLight
    case light
    case medium
    case extraBold
    case regular
    case bold
    case black
    case thin
    case semiBold
    case semiBoldItalic
    case extraBoldItalic
    case lightItalic
    case thinItalic
    case boldItalic
    case italic
    case blackItalic
    case arbnbnumber // 自定义等宽字体
    case custom(String)
    
    var name: String {
        switch self {
        case .extraLight: return OOGFontType.fontMap[self] ?? "Poppins-ExtraLight"
        case .light: return OOGFontType.fontMap[self] ?? "Poppins-Light"
        case .medium: return OOGFontType.fontMap[self] ?? "Poppins-Medium"
        case .extraBold: return OOGFontType.fontMap[self] ?? "Poppins-ExtraBold"
        case .regular: return OOGFontType.fontMap[self] ?? "Poppins-Regular"
        case .bold: return OOGFontType.fontMap[self] ?? "Poppins-Bold"
        case .black: return  OOGFontType.fontMap[self] ?? "Poppins-Black"
        case .thin: return OOGFontType.fontMap[self] ?? "Poppins-Thin"
        case .semiBold: return OOGFontType.fontMap[self] ?? "Poppins-SemiBold"
        case .semiBoldItalic:  return OOGFontType.fontMap[self] ?? "Poppins-SemiBoldItalic"
        case .extraBoldItalic: return OOGFontType.fontMap[self] ?? "Poppins-ExtraBoldItalic"
        case .lightItalic: return OOGFontType.fontMap[self] ?? "Poppins-LightItalic"
        case .thinItalic: return OOGFontType.fontMap[self] ?? "Poppins-ThinItalic"
        case .boldItalic: return OOGFontType.fontMap[self] ?? "Poppins-BoldItalic"
        case .italic: return OOGFontType.fontMap[self] ?? "Poppins-Italic"
        case .blackItalic: return OOGFontType.fontMap[self] ?? "Poppins-BlackItalic"
        case .arbnbnumber: return OOGFontType.fontMap[self] ?? "arbnbnumber6"
        case .custom(let string): return string
        }
    }
    
    
    /// 需要配置 不然会读取默认的字体
    /// - Parameter map: 字体字典
    public static func config(_ map:[OOGFontType:String]){
        OOGFontType.fontMap = map
    }
}


public extension UIFont {
    
    /// 配置字体
    /// - Parameter map: 字体 dctionary
    static func config(_ map:[OOGFontType:String]){
        OOGFontType.config(map)
    }
    
    //尺寸需要转换
    static func oog(_ type: OOGFontType,_ fontSize:CGFloat) -> UIFont{
        return UIFont.init(name: type.name, size: cX(fontSize)) ?? UIFont.systemFont(ofSize: cX(fontSize))
    }
    
    //传入真实的尺寸不需转换
    static func oogR(_ type: OOGFontType,_ fontSize:CGFloat) -> UIFont{
        return UIFont.init(name: type.name, size: fontSize) ?? UIFont.systemFont(ofSize: cX(fontSize))
    }
    
    //尺寸需要转换
    static func oog(_ type: OOGFontType,_ ipadSize:CGFloat, _ iphoneSize:CGFloat) -> UIFont{
        return UIFont.init(name: type.name, size: cIpad(ipadSize, iphoneSize)) ?? UIFont.systemFont(ofSize: cIpad(ipadSize, iphoneSize))
    }

    //传入真实的尺寸不需要转换
    static func oogR(_ type: OOGFontType,_ ipadSize:CGFloat, _ iphoneSize:CGFloat) -> UIFont{
        return UIFont.init(name: type.name, size: cIpad(ipadSize, iphoneSize)) ?? UIFont.systemFont(ofSize: rIpad(ipadSize, iphoneSize))
    }
    
}
