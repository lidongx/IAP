//
//  UI+YLabel.swift
//  UIComponents
//
//  Created by lidong on 2022/5/30.
//

import Foundation
import UIKit

///对齐方式类型
public enum VAlignmnet{
    case top   //顶对齐
    case center //中心对齐
    case bottom //下对齐
}

/// Label支持垂直对齐方式
public class VLabel : UILabel{
    
    //垂直对齐方式
    private var vAlignment_:VAlignmnet = .center
    
    public var vAlignment:VAlignmnet {
        set{
            vAlignment_ = newValue
            setNeedsDisplay()
        }
        get{
           return vAlignment_
        }
    }
    
    
    ///  重载文本显示区域
    /// - Parameters:
    ///   - bounds: label bounds
    ///   - numberOfLines: 行数
    /// - Returns: 文本显示区域
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        switch vAlignment {
        case .top:
            textRect.origin.y = bounds.origin.y
        case .center:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)/2
        case .bottom:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)
        }
        return textRect
    }
    
    
    /// 绘制
    /// - Parameter rect: 绘制矩形框
    public override func drawText(in rect: CGRect) {
        let actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: actualRect)
    }
    
}
