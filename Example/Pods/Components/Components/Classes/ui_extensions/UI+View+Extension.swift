//
//  UI+View+Base.swift
//  UIComponents
//
//  Created by lidong on 2022/5/30.
//

import Foundation
import UIKit
extension UIView{
    
    ///是否显示
    var isShow:Bool{
        get{
            return !self.isHidden
        }set{
            self.isHidden = !newValue
        }
    }
    
    /// View 初始化
    /// - Parameters:
    ///   - rect: farme
    ///   - color: 背景颜色
    convenience init(rect: CGRect, color: UIColor) {
        self.init(frame: rect)
        backgroundColor = color
    }
    
    /// 通过类名查找View
    /// - Parameters:
    ///   - name: 类名
    ///   - resursion: 是否递归
    /// - Returns: 查找的子View
    func findSubview(name: String, resursion: Bool) -> UIView? {
        if let targetClass = NSClassFromString(name) {
            for subview in self.subviews {
                if subview.isKind(of: targetClass) {
                    return subview
                }
            }
            if (resursion) {
                for subview in self.subviews {
                    let tempView = subview.findSubview(name: name, resursion: resursion)
                    if tempView != nil {
                        return tempView
                    }
                }
            }
        }
        return nil
    }
    
    /// 通过view 获取ViewController
    public var viewController:UIViewController?{
        get{
            var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder!.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    }
    
    /// 屏幕截图
    ///
    /// - Returns: optional image
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 水平翻转
    func flip() {
        self.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    //截屏指定视图区域
    func cropping(with toRect: CGRect) -> UIImage? {
        let scale = UIScreen.main.scale
        let pageSize = CGSize(width: scale * toRect.size.width, height: scale * toRect.size.height)
        UIGraphicsBeginImageContext(pageSize)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: scale, y: scale)
        
        let resizedContext = UIGraphicsGetCurrentContext()
        resizedContext?.translateBy(x: -1 * toRect.origin.x, y: -1 * toRect.origin.y)
        layer.render(in: resizedContext!)
        var imageOriginBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageOriginBackground = UIImage(cgImage: imageOriginBackground!.cgImage!, scale: scale, orientation: .up)
        return imageOriginBackground
    }
    
}


public enum ViewAnimation{
    /// Will change the color and animate if the duration > 0
    case changeColor(to: UIColor, duration: TimeInterval,callback:((Bool)->Void)? = nil)
    
    //动画改变透明度
    case changeAlpha(to:CGFloat,duration:TimeInterval,callback:((Bool)->Void)? = nil)
    
}



///Aniamtion
extension UIView{
    /// Implimntation for all cases in `ViewAnimation`
    ///
    /// - Parameter animation: ViewAnimation
    func animate(_ animation: ViewAnimation) {
        switch animation {
        case .changeColor(let color, let duration, let callback):
            UIView.animate(withDuration: duration) {
                self.backgroundColor = color
            } completion: { b in
                callback?(b)
            }
        case .changeAlpha(let alpha, let duration, let callback):
            UIView.animate(withDuration: duration, animations: {
                self.alpha = alpha
            }) { (finshed) in
                callback?(finshed)
            }
        }
    }
    
}
