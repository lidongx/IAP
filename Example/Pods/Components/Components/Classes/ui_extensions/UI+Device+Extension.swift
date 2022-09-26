//
//  UIDevice+Extension.swift
//  OOG104
//
//  Created by maning on 2020/1/22.
//  Copyright © 2020 maning. All rights reserved.
//

import UIKit

import CoreMotion

import CoreTelephony
import SystemConfiguration.CaptiveNetwork


public extension UIDevice {
    
    //MARK: - Formatter MB only
    func unitFormatter(_ bytes: Int64, _ showUnit: ByteCountFormatter.Units, _ showStyle: ByteCountFormatter.CountStyle, _ isShowUnit: Bool = false) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = showUnit //返回字符串的显示单位
        formatter.countStyle = showStyle  //返回字符串的计算单位,1000进制（file或decimal）或者1024进制（binary）
        formatter.includesUnit = isShowUnit
        return formatter.string(fromByteCount: bytes) as String
    }
        
    //MARK: - Get raw value
    var totalDiskSpaceInBytes:Int64 {
        get {
            do {
                guard let totalDiskSpaceInBytes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemSize] as? Int64 else {
                    return 0
                }
                return totalDiskSpaceInBytes
            } catch {
                return 0
            }
        }
    }
    
    var freeDiskSpaceInBytes:Int64 {
        get {
            if #available(iOS 11.0, *) {
                if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                    return space
                } else {
                    return 0
                }
            } else {
                guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
                    let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value else { return 0 }
                return freeSpace
            }
        }
    }
    
    var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
    
    //MARK: - Get StringValue Method 获取总的磁盘空间 单位MB 字符串
    func totalDiskSpace(_ unit: ByteCountFormatter.Units = .useMB, _ style: ByteCountFormatter.CountStyle = .decimal, _ isShowUnit: Bool = true) -> String {
        return unitFormatter(totalDiskSpaceInBytes, unit, style, isShowUnit)
    }

    // 获取剩余磁盘空间 单位MB 字符串
    func freeDiskSpace(_ unit: ByteCountFormatter.Units = .useMB, _ style: ByteCountFormatter.CountStyle = .decimal, _ isShowUnit: Bool = true) -> String {
        return unitFormatter(freeDiskSpaceInBytes, unit, style, isShowUnit)
    }

    // 获取使用了的磁盘空间 单位MB 字符串
    func usedDiskSpace(_ unit: ByteCountFormatter.Units = .useMB, _ style: ByteCountFormatter.CountStyle = .decimal, _ isShowUnit: Bool = true) -> String {
        return unitFormatter(usedDiskSpaceInBytes, unit, style, isShowUnit)
    }
    
    //MARK: - Get NumberValue Method  获取总的磁盘空间 单位MB float数字
    func totalDiskSpaceNumber(_ unit: ByteCountFormatter.Units = .useMB, _ style: ByteCountFormatter.CountStyle = .decimal) -> Float {
        return unitFormatter(totalDiskSpaceInBytes, unit, style).description.replacingOccurrences(of: ",", with: "").floatValue
    }

    // 获取剩余磁盘空间 单位MB float数字
    func freeDiskSpaceNumber(_ unit: ByteCountFormatter.Units = .useMB, _ style: ByteCountFormatter.CountStyle = .decimal) -> Float {
        return unitFormatter(freeDiskSpaceInBytes, unit, style).description.replacingOccurrences(of: ",", with: "").floatValue
    }

    // 获取使用了的磁盘空间 单位MB float数字
    func usedDiskSpaceNumber(_ unit: ByteCountFormatter.Units = .useMB, _ style: ByteCountFormatter.CountStyle = .decimal) -> Float {
        return unitFormatter(usedDiskSpaceInBytes, unit, style).description.replacingOccurrences(of: ",", with: "").floatValue
    }
}
