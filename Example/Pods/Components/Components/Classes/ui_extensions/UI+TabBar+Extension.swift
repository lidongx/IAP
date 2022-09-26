//
//  UI+TabBar+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation
import UIKit

public extension UITabBar{
    
    private static var _barHeight:CGFloat = 0
    //Tab bar height
    static var barHeight:CGFloat{
        get{
            if _barHeight == 0{
                _barHeight = UITabBarController().tabBar.height
            }
            return  _barHeight > 0 ? _barHeight : 49
        }
    }
}
