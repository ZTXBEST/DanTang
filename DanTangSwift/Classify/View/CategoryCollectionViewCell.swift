//
//  CategoryCollectionViewCell.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/17.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    var name : String? {
        didSet {
            imageView.kf.setImage(with: URL(string: name!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
