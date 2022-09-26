//
//  Util+File.swift
//  UIComponents
//
//  Created by lidong on 2022/6/14.
//

import Foundation

public class FileX{
    
    //获取文件的大小
    public static func size(atPath:String)->Float{
        var fileSize: Float = 0.0
        if isExist(atPath){
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: atPath) as NSDictionary
                fileSize = Float(attr.fileSize())
            } catch {}
        }
        return fileSize
    }

    
    //判断文件是否存在
    public static func isExist(_ path:String) -> Bool{
        return FileManager.default.fileExists(atPath: path)
    }
    
    //复制文件
    @discardableResult
    public static func copy(path: String, toPath: String)->Bool{
        do {
            try FileManager.default.copyItem(atPath: path, toPath: toPath)
        } catch {
            // error
            return false
        }
        return true
    }
    
    //创建文件
    public static func ceate(with path: String, data: Data?) {
        var paths = path.components(separatedBy: "/")
        paths.removeLast()
        let dirPath = paths.joined(separator: "/")
        Dir.create(dirPath)
        if !isExist(path){
            FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
        }
    }
    
    //删除文件
    @discardableResult
    public static func delete(_ path:String)->Bool{
        let path = path.contains("Documents") ? path : Dir.documents+"/"+path
        do {
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch let error as NSError{
            print(error.localizedDescription)
            return false
        }
    }
    
    //删除文件
    @discardableResult
    public static func delete(_ url:URL)->Bool{
        return delete(url.path)
    }
    
}

