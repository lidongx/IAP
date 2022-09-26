//
//  UI+CALayer+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/5/30.
//

import Foundation
import UIKit

public extension CALayer {
    /// CALayer 暂停动画
    func pauseAimation() {
        let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0
        self.timeOffset = pausedTime
    }
    //CALayer 恢复动画
    func resumeAnimation() {
        let pausedTime = self.timeOffset
        self.speed = 1
        self.timeOffset = 0
        self.beginTime = 0
        let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}

public extension CALayer{
    
    /// Border 设置
    /// - Parameters:
    ///   - color: border 颜色
    ///   - width: border宽度
    func border(color:UIColor,width:CGFloat){
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
}


public extension CALayer {
    /// Layer convert to shadow
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - radius: 阴影半径
    ///   - offset: 阴影偏移
    ///   - opacity: 阴影透明度
    func shadow(color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5){
        shadowColor = color.cgColor
        shadowOffset = offset
        shadowRadius = radius
        shadowOpacity = opacity
        masksToBounds = false
    }
    
    /// Add rounded corner to any corner
    ///
    /// - Parameters:
    ///   - corners: [CACornerMask]
    ///   - radius: corner radius
    func cornerRound(corners: UIRectCorner = .allCorners, radius: CGFloat){
        if #available(iOS 11.0, *) {
            self.cornerRadius = radius
            guard !corners.contains(.allCorners) else { return }
            self.maskedCorners = []
            if corners.contains(.topLeft) {
                self.maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.topRight) {
                self.maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                self.maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                self.maskedCorners.insert(.layerMaxXMaxYCorner)
            }
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.mask = mask
        }
    }
        
    ///   设置部分圆角
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, frame: CGRect, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        maskLayer.path = maskPath.cgPath
        self.mask = maskLayer
    }
    
}

/// 创建渐变图层
/// - Parameters:
///   - colors: 渐变色值cgColor
///   - startPoint: 渐变色开始位置
///   - endPoint: 渐变色结束位置
///   - locations: 渐变色变化位置 0～1
/// - Returns: 渐变图层
 public func createGradientLayer(with colors: [Any] = [UIColor.white.cgColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 0, y: 1), locations: [NSNumber] = [0.5]) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endPoint
    gradientLayer.locations = locations
    return gradientLayer
}


