//
//  Util+Dir.swift
//  UIComponents
//
//  Created by lidong on 2022/6/14.
//

import Foundation

//文件夹

public class Dir{
    
    //document文件夹路径
    public static var documents:String{
        return URL.documentPath
    }
    
    public static var documentsUrl:URL{
        return URL.documents
    }
    
    //缓存文件夹
    public static var caches:String{
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    
    
    @discardableResult
    public static func create(_ name:String)->Bool{
        let path = name.contains("Documents") ? name : URL.documentPath+"/"+name
        if isExist(path){
            return true
        }
        do {
            try FileManager.default.createDirectory(atPath:path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    public static func remove(_ path:String)->Bool{
        do {
            try FileManager.default.removeItem(atPath: path.contains("Documents") ? path : documents+path)
            return true
        } catch let error as NSError{
            print(error.localizedDescription)
            return false
        }
    }
    
    //文件夹是否存在
    public static func isExist(_ folderPath:String)->Bool{
        return FileManager.default.fileExists(atPath: folderPath)
    }
    
    //文件夹大小
    public static func size(_ folderPath:String)->Float{
        if folderPath.isEmpty {
            return 0
        }

        if !isExist(folderPath){
            return 0
        }
        
        var fileSize: Float = 0.0
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: folderPath)
            for file in files {
                let path = folderPath + "/\(file)"
                fileSize = fileSize + FileX.size(atPath: path)
            }
        } catch {}
        print("\(fileSize)")
        return fileSize / (1000.0 * 1000.0)
    }
    
}
