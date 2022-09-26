//
//  Util+NSMutableParagraphStyle+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/2.
//

import Foundation

public extension NSMutableParagraphStyle{
    //构建
    static func build() -> NSMutableParagraphStyle{
        return NSMutableParagraphStyle()
    }
    
    //行高缩放
    static func lineHeightMultiple(_ multiple:CGFloat)->NSMutableParagraphStyle{
        return build().lineHeightMultiple(multiple)
    }

    //以什么单位换行（或者截断）
    static func lineBreakMode(_ mode:NSLineBreakMode)->NSMutableParagraphStyle{
        return build().lineBreakMode(mode)
    }
    
    //对齐方式
    static func alignment(_ align:NSTextAlignment)->NSMutableParagraphStyle{
        return build().alignment(align)
    }
    
    //行间距
    static func lineSpace(_ space:CGFloat)->NSMutableParagraphStyle{
        return build().lineSpace(space)
    }
    
    //段落间距
    static func paragraphSpacing(_ space:CGFloat)->NSMutableParagraphStyle{
        return build().paragraphSpacing(space)
    }
    
    ///=============================================================================
    
    //行高缩放
    func lineHeightMultiple(_ multiple:CGFloat)->NSMutableParagraphStyle{
        self.lineHeightMultiple = multiple
        return self
    }
    
    //以什么单位换行（或者截断）
    func lineBreakMode(_ mode:NSLineBreakMode)->NSMutableParagraphStyle{
        self.lineBreakMode = mode
        return self
    }
    
    //对齐方式
    func alignment(_ align:NSTextAlignment)->NSMutableParagraphStyle{
        self.alignment = align
        return self
    }
    
    //行间距
    func lineSpace(_ space:CGFloat)->NSMutableParagraphStyle{
        self.lineSpacing = space
        return self
    }
    
    ///段落间距
    func paragraphSpacing(_ space:CGFloat)->NSMutableParagraphStyle{
        self.paragraphSpacing = space
        return self
    }
    
}
