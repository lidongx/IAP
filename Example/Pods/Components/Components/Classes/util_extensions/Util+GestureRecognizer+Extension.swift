//
//  Util+GestureRecognizer+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/2.
//

import Foundation
import UIKit

public extension UIGestureRecognizer{
    //移出手势
    func remove(){
        view?.removeGestureRecognizer(self)
    }
}
