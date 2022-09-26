//
//  UI+ProgressBar.swift
//  UIComponents
//
//  Created by nickey on 2022/6/2.
//

import Foundation
import UIKit

public class ProgressBar: UIView {
    
    /// 当前progress所在的位置
    var currentPositon = 1
    var views = [UIProgressView]()
    
    /// 初始化ProgressBar
    /// - Parameters:
    ///   - frame: 控件的Frame
    ///   - segmentNum: 分为几段
    ///   - segmentWidth: 每段的宽度
    ///   - segmentHeight: 每段的高度
    ///   - distance: 段间距
    ///   - segmentColor: 进度条颜色
    ///   - segmentBackgourdColor: 进度条背景色
    public init(frame: CGRect, segmentNum: Int, segmentWidth: CGFloat, segmentHeight: CGFloat, distance: CGFloat, segmentColor: UIColor, segmentBackgourdColor: UIColor) {
        super.init(frame: frame)
        
        configUI(segmentNum: segmentNum, segmentWidth: segmentWidth, segmentHeight: segmentHeight, distance: distance, segmentColor: segmentColor, segmentBackgourdColor: segmentBackgourdColor)
    }
    
    private func configUI(segmentNum: Int, segmentWidth: CGFloat, segmentHeight: CGFloat, distance: CGFloat, segmentColor: UIColor, segmentBackgourdColor: UIColor) {
        for index in 1...segmentNum {
            let progress = UIProgressView(frame: CGRect(x: CGFloat(index) * (segmentWidth + distance), y: 0, width: segmentWidth, height: segmentHeight))
            
            
            //不同设备进度条高度是不一致的，按比列进行缩放
//            let scale = self.height / progress.height
//            progress.transform = CGAffineTransform(scaleX: 1, y: scale)
            
            progress.tintColor = segmentColor
            progress.trackTintColor = segmentBackgourdColor
            if index == 1 {
                progress.progress = 1.0
            } else {
                progress.progress = 0.0
            }
            self.addSubview(progress)
            self.views.append(progress)
        }
    }
    
    /// 前往某个进度条
    /// - Parameter num: 第几个进度条
    public func nextTo(num: Int) {
        let index = num - 1
        for (i, view) in views.enumerated() {
            if i < index {
                view.progress = 1.0
            } else {
                view.progress = 0.0
            }
            if index == i {
                self.currentPositon = num
                UIView.animate(withDuration: 0.25) {
                    view.progress = 1.0
                    print("当前进度条所在位置的下标：\(self.currentPositon-1)")
                }
            }
        }
    }
    
    /// 返回到某个进度条
    /// - Parameter num: 第几个进度条
    public func prevTo(num: Int) {
        let index = num - 1
        for (i, view) in views.enumerated() {
            if i <= index + 1 {
                view.progress = 1.0
            } else {
                view.progress = 0.0
            }
            if index + 1 == i {
                self.currentPositon = num
                UIView.animate(withDuration: 0.25) {
                    view.progress = 0.0
                    print("当前进度条所在位置的下标：\(self.currentPositon-1)")
                }
            }
        }
    }
    
    /// 移动到下一个进度条
    public func moveToNextProgress() {
        nextTo(num: self.currentPositon + 1)
    }
    
    /// 返回到上一个进度条
    public func moveToPreviousProgress() {
        prevTo(num: self.currentPositon - 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
