//
//  UI+StateBar.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation
import UIKit

public class StateBar{
    
    //状态栏的高度
    public static var barHeight:CGFloat{
        get{
            var value: CGFloat = 0
            if let window = UIWindow.main{
                if #available(iOS 13.0, *) {
                    if let temp = window.windowScene?.statusBarManager?.statusBarFrame.height{
                        value = temp
                    }
                }
            }
            //默认值
            return value > 0 ? value : rIpad(44, 20)
        }
    }
    
    //是否隐藏
    public static var isHidden:Bool{
        get{
            return UIApplication.shared.isStatusBarHidden
        }
    }
    
    //状态栏方向
    public static var oriention:UIInterfaceOrientation{
        get{
            return UIApplication.shared.statusBarOrientation
        }
    }
    
}
