//
//  Util+URL+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/6/1.
//

import Foundation

public extension URL{
    
    //获取document URL
    static var documents: URL {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    //获取document Path
    static var documentPath:String{
        return documents.path
    }
    
    // url plist 文件转换为data
    var data:Data?{
        return try? Data(contentsOf: self)
    }
    
    /// 获取字符串参数字典
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    ///从查询参数中获取value
    func query(for key: String) -> String? {
        return URLComponents(string: absoluteString)?
            .queryItems?
            .first(where: { $0.name == key })?
            .value
    }
    
    //url增加 path componenet
    mutating func addPathComponent(_ component:String){
        self.appendPathComponent(component)
    }
    
    //删除所有的路径
    var deletedAllPathComponents:URL{
        var url: URL = self
        for _ in 0..<pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }
    
    //url 中增加参数
    func addingQueryParameters(_ params: [String: String]) -> URL {
        var items = [URLQueryItem]()
        for (key,value) in params{
            items.append(URLQueryItem(name: key, value: value))
        }
        guard var urlComponents = URLComponents(string: self.path) else { return self }
        if urlComponents.queryItems == nil{
            urlComponents.queryItems = .init(items)
        }else{
            urlComponents.queryItems?.append(items)
        }
        return urlComponents.url ?? self
    }
}

extension URL{
    //url 转换为模型对象
    func decode<T: Decodable>(_ type: T.Type) -> T {
        guard let data = self.data else{
            fatalError("Failed to load \(self)")
        }
        return data.decode(type)
    }
}
