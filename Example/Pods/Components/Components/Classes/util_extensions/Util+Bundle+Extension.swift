//
//  Bundle+Extension.swift
//  Helper4Swift
//
//  Created by Abdullah Alhaider on 18/05/2019.
//

import Foundation

public extension Bundle {
    
    /// Decode an exesting json file
    ///
    /// ```
    /// let model = Bundle.main.decode([Model].self, from: "modelss.json")
    /// ```
    ///解码成对象
    /// - Parameters:
    ///   - type: Decodable object
    ///   - file: file name or uel
    /// - Returns: decoded object
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in app bundle.")
        }
        return url.decode(type)
    }
}


public extension Bundle {
    
    /// app Name
    /// returns the value accessed with the key `CFBundleName`.
    var appName: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let name = infoDictionary["CFBundleName"] as? String else { return "unknown" }
        return name
    }
    
    /// bundle id
    /// returns the value accessed with the key `CFBundleIdentifier`.
    var bundleIdentifier: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let bundleIdentifier = infoDictionary["CFBundleIdentifier"] as? String else { return "unknown" }
        return bundleIdentifier
    }
    
    /// Build 版本号
    /// returns the value accessed with the key `CFBundleVersion`.
    var buildNumber: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let buildNumber = infoDictionary["CFBundleVersion"] as? String else { return "unknown" }
        return buildNumber
    }
    
    /// 版本号
    /// returns the value accessed with the key `CFBundleShortVersionString`.
    var versionNumber: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let versionNumber = infoDictionary["CFBundleShortVersionString"] as? String else { return "unknwon" }
        return versionNumber
    }
    
    /// 大版本号
    /// the value accessed with the key `CFBundleShortVersionString` and parses
    /// it to return the version major number.
    ///
    /// - Returns: the version number of the Xcode project as a whole(e.g. 1.0.3)
    var versionMajorNumber: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let versionNumber = infoDictionary["CFBundleShortVersionString"] as? String else { return "unknwon" }
        return versionNumber.components(separatedBy: ".")[0]
    }
    
    /// 中间版本号
    /// the value accessed with the key `CFBundleShortVersionString` and parses
    /// it to return the version minor number.
    var versionMinorNumber: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let versionNumber = infoDictionary["CFBundleShortVersionString"] as? String else { return "unknwon" }
        return versionNumber.components(separatedBy: ".")[1]
    }
    
    /// 小版本号
    /// the value accessed with the key `CFBundleShortVersionString` and parses
    /// it to return the version patch number.
    var versionPatchNumber: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        guard let versionNumber = infoDictionary["CFBundleShortVersionString"] as? String else { return "unknwon" }
        return versionNumber.components(separatedBy: ".")[2]
    }
    
    /// Retrieves the `infoDictionary` dictionary inside Bundle, and retrieves
    /// all the values inside it
    var getInfoDictionary: [String: Any] {
        guard let infoDictionary = Bundle.main.infoDictionary else { return [:] }
        return infoDictionary
    }
    
}

