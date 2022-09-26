//
//  Util+SafeArea.swift
//  Routine
//
//  Created by 王理朝 on 2022/7/18.
//

import Foundation

@available(iOS 11.0, *)
public struct SafeArea {
    public static var top: CGFloat {
        guard let window = UIWindow.main else { return 0 }
        return window.safeAreaInsets.top
    }
    
    public static var bottom: CGFloat {
        guard let window = UIWindow.main else { return 0 }
        return window.safeAreaInsets.bottom
    }
    
}
