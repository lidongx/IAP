//
//  Util+NSAttributedString+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/2.
//

import Foundation

///说明 NSAttributedString
///  开始调用 range 否者 就是设置所有的字符串



///可以通过string 直接点出来
public extension NSMutableAttributedString {
    
    //运行时存储Key
    private struct AssociatedKeys{
        static var actionKey = "actionKey"
    }
        
    @objc private dynamic var range: NSRange {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let range = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? NSRange{
                return range
            }
            //默认的range
            return NSMakeRange(0, (self.string as NSString).length)
        }
    }
    
    /// 增加Attribute
    /// - Parameter attributes: 属性字典
    /// - Returns: NSAttributedString
    func apply(_ attributes: [NSAttributedString.Key:Any], _ range:NSRange) -> NSMutableAttributedString {
        self.addAttributes(attributes, range: range)
        return self
    }
    
    ///文本颜色
    func foregroundColor(_ color: UIColor) -> NSMutableAttributedString {
        self.apply([.foregroundColor : color],self.range)
    }
    
    ///背景颜色
    func background(_ color: UIColor) -> NSMutableAttributedString {
        self.apply([.backgroundColor: color],self.range)
    }
    
    //下划线
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSMutableAttributedString {
        self.apply([.underlineColor: color, .underlineStyle: style.rawValue],self.range)
    }
    
    //设置的字体
    func font(_ font: UIFont) -> NSMutableAttributedString {
        self.apply([.font: font],self.range)
    }
    
    //紧缩字符间的字距
    func kern(_ kern:CGFloat)->NSMutableAttributedString{
        self.apply([.kern:kern],self.range)
    }
    
    //相对于字符串基线的偏移量
    func baselineOffset(_ offset:CGFloat = 0.0)->NSMutableAttributedString{
        self.apply([.baselineOffset:offset],self.range)
    }
    
    //设置段落样式
    func style(_ style:NSMutableParagraphStyle)->NSMutableAttributedString{
        self.apply([.paragraphStyle:style],self.range)
    }
    
    //设置阴影
    func shadow(_ shadow: NSShadow) -> NSMutableAttributedString {
        self.apply([.shadow:shadow],self.range)
    }
    
    //设置range 一开始就调用
    func range(_ rangle:NSRange)->NSMutableAttributedString{
        self.range = rangle
        return self
    }
    
    //整个字符串的范围
    func allRange()->NSMutableAttributedString{
        self.range = NSMakeRange(0, (self.string as NSString).length)
        return self
    }
    
    //查找字符串
    func findRange(_ subString:String)->NSMutableAttributedString{
        let range = (self.string as NSString).range(of: subString)
        self.range = range
        return self
    }
}
