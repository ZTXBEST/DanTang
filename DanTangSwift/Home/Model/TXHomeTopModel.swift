//
//  TXHomeTopModel.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/6.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class TXHomeTopModel: NSObject {
    var editable: Bool?
    var id: Int?
    var name: String?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }
}
