//
//  AppExtensions.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 21/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit

class AppExtensions: NSObject {
    
}
extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: size.width, height: lineHeight)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

