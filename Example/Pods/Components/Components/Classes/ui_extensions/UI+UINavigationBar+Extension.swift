//
//  UI+UINavigationBar+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation

public extension UINavigationBar{
    
    private static var _barHeight:CGFloat = 0
    
    //状态栏的高度
    static var barHeight:CGFloat{
        get{
            if _barHeight == 0{
                _barHeight = UINavigationController().navigationBar.height
            }
            return _barHeight > 0 ? _barHeight : 44
        }
    }
}
