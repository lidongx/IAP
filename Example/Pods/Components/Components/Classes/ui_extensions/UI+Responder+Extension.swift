//
//  UI+Responder+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/10.
//

import Foundation
import UIKit

extension UIResponder{
    //运行时存储Key
    private struct AssociatedKeys{
        static var actionKey = "actionKey"
    }
        
    //保存的数据
    @objc dynamic var data: Any? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.actionKey){
                return data
            }
            return nil
        }
    }
}
