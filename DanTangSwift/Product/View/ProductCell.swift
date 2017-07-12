//
//  ProductCell.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/11.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    var iconView : UIImageView?
    var titleLabel : UILabel?
    var priceLabel : UILabel?
    var likeBtn : UIButton?
    
    var model : TXProductModel? {
        didSet {
            iconView?.kf.setImage(with: URL(string: (model?.cover_image_url)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            titleLabel?.text = model?.name
            priceLabel?.text = "￥" + (model?.price)!
            likeBtn?.setTitle(" "+String(model!.favorites_count!)+" ", for: .normal)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.colorWithHexString(hex: "#000000").cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)//偏移距离
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOpacity = 0.8;//不透明度
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        initView()
    }
    
    func initView() {
        iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.width, height: 164))
        self.contentView.addSubview(iconView!)
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = .left
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((iconView?.snp.bottom)!).offset(12)
            make.left.equalTo(self.contentView).offset(5)
            make.width.equalTo(self.width-10)
            make.height.equalTo(20)
        })
        
        likeBtn = UIButton()
        likeBtn?.setImage(UIImage(named: "Search_GiftBtn_Default_12x10_"), for: .normal)
        likeBtn?.setTitle(" "+"0"+" ", for: .normal)
        likeBtn?.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
        likeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        self.contentView.addSubview(likeBtn!)
        likeBtn?.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
        
        priceLabel = UILabel()
        priceLabel?.textAlignment = .left
        priceLabel?.textColor = TXColor(r: 232, g: 84, b: 85, a: 1)
        priceLabel?.font = UIFont.systemFont(ofSize: 15.0)
        self.contentView.addSubview(priceLabel!)
        priceLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(titleLabel!)
            make.centerY.equalTo(likeBtn!)
            make.height.equalTo(25)
            make.width.equalTo(self.width/2)
        })
        
//        let line = UIView(frame: CGRect(x: 0, y: self.height-0.5, width: self.width, height: 0.5))
//        line.backgroundColor = UIColor.colorWithHexString(hex: "#cccccc")
//        self.contentView.addSubview(line)
    }
}
