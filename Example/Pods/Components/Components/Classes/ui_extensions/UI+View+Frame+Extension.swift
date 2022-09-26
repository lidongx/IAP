//
//  Extension+UIView.swift
//  ModuleProject
//
//  Created by guoqiang on 2021/11/2.
//

import UIKit

public extension UIView {
    // MARK: - 常用位置属性
    var x: CGFloat {
        get {
            return frame.minX//frame.origin.x
        }
        set(newX) {
            var frame = self.frame
            frame.origin.x = newX
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        get {
            return frame.minY//frame.origin.y
        }
        
        set(newY) {
            var frame = self.frame
            frame.origin.y = newY
            self.frame = frame
        }
    }
    
    
    var width: CGFloat {
        get {
            return frame.width//frame.size.width
        }

        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }

    var height: CGFloat {
        get {
            return frame.height//frame.size.height
        }

        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }

    var centerX: CGFloat {
        get {
            return frame.midX//center.x
        }

        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }

    var centerY: CGFloat {
        get {
            return frame.midY//center.y
        }

        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }

    var maxX: CGFloat {
        return frame.maxX
    }

    var maxY: CGFloat {
        return frame.maxY
    }

    var minX: CGFloat {
        return frame.minX
    }

    var minY: CGFloat {
        return frame.minY
    }

    var middleX: CGFloat {
        return frame.midX
    }

    var middleY: CGFloat {
        return frame.midY
    }
    
    var top:CGFloat{
        return self.minY
    }
    
    var bottom:CGFloat{
        return maxY
    }
    
    var right:CGFloat{
        return maxX
    }
    
    var left:CGFloat{
        return minX
    }
}

