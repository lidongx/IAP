//
//  UINavigationController+Extension.swift
//  Router
//
//  Created by lidong on 2022/5/23.
//

import Foundation
import UIKit
import QuartzCore

public extension UINavigationController{
    
    ///  push动画
    /// - Parameters:
    ///   - viewController: 目标VC
    ///   - type: 转换类型
    ///   - subType: 方向
    ///   - key: Aniamtion Key
    func pushTrans(_ viewController:UIViewController,_ type:CATransitionType,_ subType:CATransitionSubtype? = nil,_ key:String? = nil){
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        if let subType = subType {
            transition.subtype = subType
        }
        self.view.layer.add(transition, forKey: key)
        self.pushViewController(viewController, animated: false)
    }
    
    func pushFromLeft(_ viewController:UIViewController){
        pushTrans(viewController, .reveal, .fromLeft,kCATransition)
    }
    
    func pushFromBottom(_ viewController:UIViewController){
        pushTrans(viewController, .moveIn, .fromTop,kCATransition)
    }
    
    func pushFromTop(_ viewController:UIViewController){
        pushTrans(viewController, .push, .fromBottom,kCATransition)
    }
    
    func pushFromFade(_ viewController:UIViewController){
        pushTrans(viewController, .fade)
    }
    
    
    /// pop动画
    /// - Parameters:
    ///   - type: 动画类型
    ///   - subType: 动画方向
    ///   - key: 动画key
    func popTrans(_ type:CATransitionType,_ subType:CATransitionSubtype? = nil,_ key:String? = nil){
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        if let subType = subType {
            transition.subtype = subType
        }
        self.view.layer.add(transition, forKey: key)
        self.popViewController(animated: false)
    }
    
    ///  pop动画
    /// - Parameters:
    ///   - viewController: 目标VC
    ///   - subType: 方向
    ///   - key: Aniamtion Key
    func popTrans(to viewController:UIViewController,_ type:CATransitionType,_ subType:CATransitionSubtype? = nil,_ key:String? = nil){
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        if let subType = subType {
            transition.subtype = subType
        }
        self.view.layer.add(transition, forKey: key)
        self.popToViewController(viewController, animated: false)
    }
    
    
    /// 向顶部pop
    func popTrendTop(){
        popTrans(.reveal, .fromTop,kCATransition)
    }
    
    func popTrendBottom(){
        popTrans(.reveal, .fromBottom,kCATransition)
    }
    
    func popTrendRight(){
        popTrans(.reveal, .fromRight,kCATransition)
    }
    
    func popTrendFade(){
        popTrans(.fade)
    }
    
    func popTrendTop(_ viewController:UIViewController){
        popTrans(to: viewController, .reveal, .fromTop,kCATransition)
    }
    
    func popTrendBottom(_ viewController:UIViewController){
        popTrans(to: viewController, .reveal, .fromBottom,kCATransition)
    }
    
    func popTrendRight(_ viewController:UIViewController){
        popTrans(to: viewController, .reveal, .fromRight,kCATransition)
    }
    
    func popTrendFade(_ viewController:UIViewController){
        popTrans(to: viewController, .fade)
    }
}


