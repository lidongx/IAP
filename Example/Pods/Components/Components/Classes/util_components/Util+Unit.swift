//
//  Util+Unit.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation

let lbs_kg_convert_value:CGFloat = 2.2046
let cm_inch_convert_value:CGFloat = 0.39370

public class Unit{
    //lbs 转换为kg
    public static func kgFromLbs(with lbs:CGFloat)->CGFloat{
        return lbs/lbs_kg_convert_value
    }
    
    //kg转换为lbs
    public static func lbsFromKg(with kg:CGFloat)->CGFloat{
        return kg*lbs_kg_convert_value
    }
    
    //厘米转换成英寸
    public static func cmFromInch(with inch:CGFloat)->CGFloat{
        return inch/cm_inch_convert_value
    }
    
    //英寸转换为厘米
    public static func inchFromCm(with cm:CGFloat)->CGFloat{
        return cm*cm_inch_convert_value
    }
    
}
