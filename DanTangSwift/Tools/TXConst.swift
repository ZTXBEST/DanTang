//
//  TXConst.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SVProgressHUD


enum TXShareButtonType: Int {
    /// 微信朋友圈
    case WeChatTimeline = 0
    /// 微信好友
    case WeChatSession = 1
    /// 微博
    case Weibo = 2
    /// QQ 空间
    case QZone = 3
    /// QQ 好友
    case QQFriends = 4
    /// 复制链接
    case CopyLink = 5
}

/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64

/// 屏幕的宽
let KScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高
let KScreenHeight = UIScreen.main.bounds.size.height

// 请求成功
let RETURN_OK = 200

let BASE_URL = "http://api.dantangapp.com/"

/// 间距
let kMargin: CGFloat = 10.0

func TXColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
//    return UIColor(red:r/255.0,green:g/255.0,blue:b/255.0,alpha:a);
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
}

/// 红色
func TXGlobalRedColor() -> UIColor {
    return TXColor(r: 245, g: 80, b: 83, a: 1.0)
}

/// 背景灰色
func TXGlobalColor() -> UIColor {
    return TXColor(r: 240, g: 240, b: 240, a: 1)
}
