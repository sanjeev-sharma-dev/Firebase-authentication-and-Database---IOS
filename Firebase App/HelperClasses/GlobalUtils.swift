//
//  GlobalUtils.swift
//  Firebase App
//
//  Created by Tbi-Pc-22 on 05/09/18.
//  Copyright © 2018 Tbi-Pc-22. All rights reserved.
//

import UIKit
import SVProgressHUD
import SystemConfiguration


class GlobalUtils: NSObject {

    static let sharedInstance = GlobalUtils()
    
    
    func showAlert(viewcontroller: UIViewController, message: String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    func showLoader()
    {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
        }
    }
    
    /*!
     @brief its used to hide loader from screen when user get the response
     */
    func hideLoader()
    {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}
