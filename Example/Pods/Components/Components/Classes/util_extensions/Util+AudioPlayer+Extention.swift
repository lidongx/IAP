//
//  AVAudioPlayer+Extention.swift
//  OOG104
//
//  Created by maning on 2019/7/31.
//  Copyright © 2019 maning. All rights reserved.
//

import Foundation
import AVFoundation

public extension AVAudioPlayer {
    
    //运行时属性key
    private struct AssociatedKey {
        static var identifier: Int = 0
    }
    
    //增加运行时属性
    var tag: Int {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKey.identifier) as? Int)!
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
