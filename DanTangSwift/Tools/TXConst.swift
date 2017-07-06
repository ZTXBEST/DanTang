//
//  TXConst.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

let BASE_URL = "http://api.dantangapp.com/"

func TXColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
//    return UIColor(red:r/255.0,green:g/255.0,blue:b/255.0,alpha:a);
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
}

/// 红色
func TXGlobalRedColor() -> UIColor {
    return TXColor(r: 245, g: 80, b: 83, a: 1.0)
}
