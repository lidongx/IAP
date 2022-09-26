//
//  UI+Label+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/5/30.
//

import Foundation
import UIKit


public extension UILabel {
    
    /// 创建UILabel
    /// - Parameters:
    ///   - frame: frame
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - font: 文本字体
    ///   - textAligment: 对齐方式
    convenience init(frame:CGRect = .zero, text:String? = nil,textColor:UIColor? = nil,font:UIFont? = nil,textAligment:NSTextAlignment? = nil) {
        self.init(frame: frame)
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let font = font {
            self.font = font
        }
        self.text = text
        if let textAligment = textAligment {
            self.textAlignment = textAligment
        }
    }
    
    
    /// 创建UILabel
    /// - Parameters:
    ///   - frame: frame
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - textAligment: 对齐方式
    convenience init(frame:CGRect = .zero, text:String? = nil,textColor:UIColor? = nil,textAligment:NSTextAlignment? = nil) {
        self.init(frame: frame, text: text, textColor: textColor, font: nil, textAligment: textAligment)
    }

    /// 根据文本label可以显示的最大行数
    var maxNumberOfLines:Int{
        let lineHeight = font.lineHeight
        return Int(ceil(self.maxTextHeight / lineHeight))
    }
    
    ///label文本最大高度
    var maxTextHeight:CGFloat{
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as Any], context: nil).height
       return textHeight
    }
}


public extension UILabel{
    /// 设置渐变文字 使用该方法时 不能再设置 textColor 属性 且startPotint 和 endPoint 为实际坐标点
    /// - Parameters:
    ///   - colors: 渐变色数组
    ///   - startPoint: 渐变起始点
    ///   - endPoint: 渐变结束点
    ///   - locations: 渐变location
    func setGradient(with colors: [CGColor] = [UIColor.white.cgColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1), locations: [NSNumber] = [0.5]) {
        ///生成渐变颜色图片
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        ///设置渐变颜色
        guard let gradientRef = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil) else {
            UIGraphicsEndImageContext()
            return
        }
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: self.frame.size.width, y: 0)
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return
        }
        UIGraphicsEndImageContext()
        self.textColor = UIColor(patternImage: gradientImage)
    }
}
