//
//  APPConfig.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/17.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class APPConfig: NSObject {
    class func getCurrentNav() -> UINavigationController? {
        return  getRootVC().selectedViewController as! TXNavigationController
    }
    
    class func getRootVC() -> UITabBarController {
        return  Application.window?.rootViewController as! TXTabBarController
    }
    
    class func getCurrentVC() -> UIViewController {
        
        let current = getCurrentNav()
        return (current?.viewControllers.last!)!
    }
}
