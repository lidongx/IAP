//
//  RouterX+Node.swift
//  RouterX
//
//  Created by lidong on 2022/5/24.
//

import Foundation
import UIKit

public typealias HandleRouteCallback = (_ source:UIViewController?,_ params:[String:Any]?)->UIViewController?

extension RouterX{
    
    /// 路由增加节点
    /// - Parameters:
    ///   - url: url路径
    ///   - node: 节点
    func addNode(_ url:String, _ node:Node){
        nodeMap[url.getUrlKey()] = node
    }
    
    func getNode(_ url:String)->Node?{
        return nodeMap[url.getUrlKey()]
    }
    
    func removeNode(_ url:String){
        nodeMap.removeValue(forKey: url.getUrlKey())
    }
    
    func removeAllNode(){
        nodeMap.removeAll()
    }
    
    
    class Node{
        var url:String = ""
        var handle:HandleRouteCallback? = nil
        var queryParams:[String:String]? = nil
        var urlKey:String  = ""
        init(_ url:String,_ handle:HandleRouteCallback? = nil){
            self.url = url
            self.handle = handle
            self.queryParams = URL(string: url)?.queryParameters
            self.urlKey = url.getUrlKey()
        }
        
        func callHandle(_ source:UIViewController?,_ params:[String:Any]? = nil)->UIViewController?{
            var resParam = [String:Any]()
            if let params = params {
                resParam = params
            }
            if let queryParams = self.queryParams , queryParams.keys.count > 0{
                for key in queryParams.keys{
                    resParam[key] = queryParams[key]
                }
            }
            return self.handle?(source,resParam)
        }
        
    }
}

extension String{
    func getUrlKey()->String{
        if self.isEmpty{
            assert(false,"url is empty")
            return ""
        }
        return self.components(separatedBy: "?")[0]
    }
}
