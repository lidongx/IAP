//
//  RouterX.swift
//  RouterX
//
//  Created by lidong on 2022/5/24.
//

import Foundation
import UIKit

public class RouterX{
    public static let shared = RouterX()
    var nodeMap = [String:Node]()
    
    public static func add(_ url:String,_ handle:HandleRouteCallback? = nil){
        let node = Node(url, handle)
        RouterX.shared.addNode(url, node)
    }
    
    public static func remove(_ url:String){
        RouterX.shared.removeNode(url)
    }
    
    public static func removeAll(){
        RouterX.shared.removeAllNode()
    }
}

extension RouterX{
    @discardableResult
    public static func push(_ url:String,_ source:UIViewController, _ animationType:PushAniamtionType = .defaultType,_ params:[String:Any]? = nil)->Bool{
        
        guard let node = RouterX.shared.getNode(url) else{
            assert(false,"url is not register,url=\(url)")
            return false
        }
        
        guard let target = node.callHandle(source, params) else{
            return false
        }
        
        switch animationType {
        case .defaultType:
            source.navigationController?.pushViewController(target, animated: true)
        case .none:
            source.navigationController?.pushViewController(target, animated: false)
        case .fromLeft:
            source.navigationController?.pushFromLeft(target)
        case .fromBottom:
            source.navigationController?.pushFromBottom(target)
        case .fromTop:
            source.navigationController?.pushFromTop(target)
        case .fade:
            source.navigationController?.pushFromFade(target)
        }
        
        return true
    }
    
    public static func pop(_ source:UIViewController, _ animationType:PopAniamtionType = .defaultType){
        switch animationType {
        case .defaultType:
            source.navigationController?.popViewController(animated: true)
        case .none:
            source.navigationController?.popViewController(animated: false)
        case .trendRight:
            source.navigationController?.popTrendRight()
        case .trendTop:
            source.navigationController?.popTrendTop()
        case .trendBottom:
            source.navigationController?.popTrendBottom()
        case .fade:
            source.navigationController?.popTrendFade()
        }
    }
    
    public static func pop(_ source:UIViewController, _ target:UIViewController,_ animationType:PopAniamtionType = .defaultType){
        switch animationType {
        case .defaultType:
            source.navigationController?.popToViewController(target, animated: true)
        case .none:
            source.navigationController?.popToViewController(target, animated: false)
        case .trendRight:
            source.navigationController?.popTrendRight(target)
        case .trendTop:
            source.navigationController?.popTrendTop(target)
        case .trendBottom:
            source.navigationController?.popTrendBottom(target)
        case .fade:
            source.navigationController?.popTrendFade(target)
        }
    }
    
    public static func present(_ url:String,_ source:UIViewController,_ params:[String:Any]? = nil,_ completion: (() -> Void)? = nil){
        guard let node = RouterX.shared.getNode(url) else{
            assert(false,"url is not register,url=\(url)")
            return
        }
        guard let target = node.callHandle(source, params) else{
            return
        }
        source.present(target, animated: true, completion: completion)
    }
    
    public static func dismiss(_ target:UIViewController,_ completion: (() -> Void)? = nil){
        target.dismiss(animated: true, completion: completion)
    }
    
}
