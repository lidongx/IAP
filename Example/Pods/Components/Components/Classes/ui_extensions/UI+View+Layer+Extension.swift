//
//  UI+View+Layer.swift
//  UIComponents
//
//  Created by lidong on 2022/5/30.
//

import Foundation
import UIKit

public extension UIView{
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor? {
        get {
            return self.layer.borderColor
        }
        set {
            self.layer.borderColor = newValue
        }
    }
    
    /// 设置部分圆角
    /// - Parameters:
    ///   - corners: 设置圆角的部分数组
    ///   - radii: 半径大小
    func corner(byRoundingCorners corners: UIRectCorner,radii: CGFloat) {
        self.layer.corner(byRoundingCorners: corners,frame: self.bounds, radii: radii)
    }
    
    ///   设置部分圆角
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, frame: CGRect, radii: CGFloat) {
        self.layer.corner(byRoundingCorners: corners, frame: frame, radii: radii)
    }
    
    /// Add rounded corner to any corner
    /// - Parameters:
    ///   - corners: UIRectCorner
    ///   - radius: 圆角半径
    func cornerRound(corners: UIRectCorner = .allCorners, radius: CGFloat){
        self.layer.cornerRound(corners: corners, radius: radius)
    }
    
    
    /// 快速添加渐变色，当使用约束布局时，必须在`layoutSubViews`之后调用才有效果
    /// - Parameters:
    ///   - colors: 渐变色值cgColor
    ///   - startPoint: 渐变色开始位置
    ///   - endPoint: 渐变色结束位置
    ///   - locations: 渐变色变化位置
    /// - Returns: void
    func addGradientLayer(with colors: [Any] = [UIColor.white.cgColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1), locations: [NSNumber] = [0.5]) -> Void {
        let gradientLayer = createGradientLayer(with: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


/// 创建阴影View
/// - Parameter frame: frame
public func createShadowView(frame:CGRect)->UIView{
    let view = UIView(frame: frame)
    view.layer.shadow()
    return view
}

