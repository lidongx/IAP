//
//  Router+AnimationType.swift
//  Router
//
//  Created by lidong on 2022/5/20.
//

import Foundation

extension RouterX{
    public enum PushAniamtionType:Int {
        case defaultType  //默认方式 从右边进入
        case none       //无动画
        case fromLeft   //从左边进入
        case fromBottom //从下面进入
        case fromTop    //从顶部进入
        case fade     //渐入
    }

    public enum PopAniamtionType:Int {
        case defaultType   //默认方式 从左边出去
        case none         //无动画
        case trendRight   //从右边出去
        case trendTop     //从顶部出去
        case trendBottom  //从底部出去
        case fade         //渐出
    }

}
