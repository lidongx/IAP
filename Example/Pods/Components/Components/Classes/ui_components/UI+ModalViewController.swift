//
//  UI+XViewController.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation
import UIKit

//ModalViewController 作用
//解决模态转场非全屏问题

//这里使用open 不能用public ,public 不能被继承
open class ModalViewController : UIViewController{
    //获取viewcontroll 下面的那个viewcontroller
    public var previous:UIViewController?{
        var top = self.presentingViewController
        while top != nil {
            if let nav = top as? UINavigationController {
                top = nav.topViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else{
               return top
            }
        }
        return top
    }
    
    public var isFullScreenForModalPresentation:Bool{
        if self.modalPresentationStyle == .fullScreen || self.modalPresentationStyle == .overFullScreen{
            return true
        }
        return false
    }
    
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置代理
        if self.presentationController?.delegate == nil{
            self.presentationController?.delegate = self
        }

        if !self.isFullScreenForModalPresentation{
            self.previous?.viewWillDisappear(animated)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !self.isFullScreenForModalPresentation{
            self.previous?.viewDidDisappear(animated)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //移除代理 下个页面的调用这个页面的disappear不再往下传递
        self.presentationController?.delegate = nil
    }
    
}


@available(iOS 13.0, *)
extension ModalViewController: UIAdaptivePresentationControllerDelegate {
    //能否下拉dismiss
    // 或者不实现这个协议，设置self.isModalInPresentation（true-不允许下拉关闭，false-可以下拉关闭）
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
    
    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if !self.isFullScreenForModalPresentation{
            self.previous?.viewWillAppear(true)
            self.previous?.viewDidAppear(true)
        }
    }
}
