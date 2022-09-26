//
//  UI+Alert.swift
//  UIComponents
//
//  Created by nickey on 2022/6/2.
//

import Foundation
import UIKit

//class Alert: UIAlertController {
//    public func alert(title: String, message: String, buttonTitles:[String], handlers: [((UIAlertAction) -> Void)]? = nil) {
//
//    }
//}

public struct Alert {
    /// 弹出警告框（如果只有一个按钮可只设置左边按钮文字和方法）
    /// - Parameters:
    ///   - viewController: 警告框显示的ViewController
    ///   - title: 标题
    ///   - message: 内容
    ///   - leftButtonTitle: 左边按钮文字
    ///   - rightButtonTitle: 右边按钮文字
    ///   - leftButtonHandler: 左边按钮点击方法
    ///   - rightButtonHandler: 右边按钮点击方法
    static public func showAlert(
        _ viewController: UIViewController,
        _ title:String,
        _ message: String,
        _ leftButtonTitle: String,
        _ rightButtonTitle: String? = nil,
        _ leftButtonHandler: (()->())?,
        _ rightButtonHandler: (()->())? = nil
    ) {
        
        let alertViewController = UIAlertController(view: viewController.view, title: title, message: message, preferredStyle: .alert)
        let leftAction = UIAlertAction(title: leftButtonTitle, style: .default) { _ in
            leftButtonHandler?()
        }
        alertViewController.addAction(leftAction)
        
        if rightButtonTitle != nil {
            let rightAction = UIAlertAction(title: rightButtonTitle, style: .default) { _ in
                rightButtonHandler?()
            }
            alertViewController.addAction(rightAction)
        }
        
        viewController.present(alertViewController, animated: true)
    }
}

extension UIAlertController {
    /// 初始化UIAlertController，有iPad相关的适配
    /// - Parameters:
    ///   - view: viewController的视图view
    ///   - title: 标题
    ///   - message: 内容
    ///   - preferredStyle:alert的类型
    convenience init(view: UIView?, title: String?, message: String?, preferredStyle: UIAlertController.Style) {
        var style = preferredStyle
        ///适配ipad 系统弹窗
        ///iPad中UIAlertControllerStyleAlert的样式和iPhone的UIAlertControllerStyleActionSheet的样式是一样的
        
        if UIAlertController.isPad() && preferredStyle == .actionSheet {
            style = .alert
        }
        self.init(title: title, message: message, preferredStyle: style)
        if !UIAlertController.isPad() { return }
        ///适配ipad
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = CGRect(x: view?.bounds.midX ?? 0, y: view?.bounds.midY ?? 0, width: 0, height: 0)
        popoverPresentationController?.permittedArrowDirections = []
    }
    
    static private func isPad() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .pad) ? true : false
    }
}
