//
//  UITableViewCellExt.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/17.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class UITableViewCellExt: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    func initView() {
        
    }
}
