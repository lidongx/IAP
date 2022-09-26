//
//  Extension+UIImageView.swift
//  ModuleProject
//
//  Created by guoqiang on 2021/11/3.
//

import UIKit


/// 创建图像
/// - Parameters:
///   - frame: CGRect
///   - color: 图片颜色
/// - Returns: 图像
public func image(with frame: CGRect?, color: UIColor) -> UIImage? {
    let imageWidth = (frame == nil) ? 1.0 : frame?.size.width
    let imageHeight = (frame == nil) ? 1.0 : frame?.size.height

    let rect: CGRect = CGRect(x: 0, y: 0, width: imageWidth!, height: imageHeight!)
    UIGraphicsBeginImageContext(rect.size)
    
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    context.setFillColor(color.cgColor)
    context.fill(rect)
    
    //color.setFill()
    //UIRectFill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
}

public extension UIImage {
    // 改变图片内容颜色
    func with(_ color: UIColor) -> UIImage? {
        var newImage: UIImage?
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, scale)

        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0, y: -imageRect.size.height)
        context?.clip(to: imageRect, mask: cgImage!)
        context?.setFillColor(color.cgColor)
        context?.fill(imageRect)

        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    //获取像素点的颜色
    func color(at point: CGPoint) -> UIColor? {
        let x = point.x
        let y = point.y
        if x < 0 || x > size.width || y < 0 || y > size.height {
            return nil
        }
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * Int(y)) + Int(x)) * numberOfComponents
        
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
        let a = CGFloat(data![pixelData + 3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
        
    }
}

public extension UIImage{
    //保存图片
    func save(to url:URL)->Bool{
        // Convert to Data
        guard let data = self.jpegData(compressionQuality: 1) ?? self.pngData() else {
            return false
        }
        do {
            try data.write(to: url)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    
    /// read image from image url
    convenience init?(with url:URL){
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: 1.0)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
    
}
