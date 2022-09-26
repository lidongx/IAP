//
//  Extension+UIWindow.swift
//  SevMinWorkout
//
//  Created by mac on 2021/12/7.
//

import Foundation
import UIKit

let window_sub_child_tag = 989898

public extension UIWindow{
    
    private static var _main:UIWindow? = nil
    ///Main Window
    static var main:UIWindow?{
        get{
            if _main != nil{
                return _main
            }
            //经过测试 所有的window最终会在UIApplication.shared.windows中
            //UIWindowScene中的window还是AppleDeleagte中的window
            for window in UIApplication.shared.windows{
                if window.isHidden == false{
                    return window
                }
            }
            return nil
        }set{
            _main = newValue
        }
    }
}


//显示Toast
public func showToast(text:String?){
    #if DEBUG
    let resText:String = (text == nil) ? "" : text!
    UIApplication.shared.windows.first?.showText(text: resText)
    #endif
}

public extension UIWindow {
    //最上层的ViewControler
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
    
    //显示Toast
    func showText(text:String)  {
#if DEBUG
        if let resView = self.viewWithTag(window_sub_child_tag){
            resView.layer.removeAllAnimations()
            resView.removeFromSuperview()
        }
        
        if(text == ""){
            return
        }
        addLabel(text: text)
#endif
    }
    
    fileprivate func addLabel(text:String){
        let label = UILabel(frame: .zero)
        label.text = text
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .red
        label.sizeToFit()
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: label.frame.size.width+20, height: label.frame.size.height+20))
        view.backgroundColor = .black
        view.addSubview(label)
        label.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        view.layer.cornerRadius = 4.0
        
        view.tag = window_sub_child_tag
        self.addSubview(view)
        
        self.bringSubviewToFront(view)
        
        view.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height - 50)
        
        
        self.startAnimation()
    }
    
    //执行出现的渐变动画
    fileprivate func startAnimation(){
        let resView = self.viewWithTag(window_sub_child_tag)
        resView?.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            resView?.alpha = 1.0
        }) { (b) in
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                DispatchQueue.main.async {
                    self.endAnimation()
                }
            })
        }
    }
    
    //执行消失的渐变动画
    fileprivate func endAnimation(){
        let resView = self.viewWithTag(window_sub_child_tag)
        UIView.animate(withDuration: 0.3, animations: {
            resView?.alpha = 0
        }) { (b) in
            resView?.removeFromSuperview()
        }
    }
    
}
