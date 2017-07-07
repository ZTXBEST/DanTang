//
//  HomeCell.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/7.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
class HomeCell: UITableViewCell {
    
    var bgImageView = UIImageView()
    var favoriteBtn = UIButton()
    var titleLabel = UILabel()

    var homeModel : TXHomeModel? {
        didSet {
            bgImageView.kf.setImage(with: URL(string:(homeModel?.cover_image_url)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            titleLabel.text = homeModel?.title
            favoriteBtn.setTitle(" "+String(homeModel!.likes_count!)+" ", for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    func initView() {
        bgImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: KScreenWidth-20, height: 160-20))
        bgImageView.layer.cornerRadius = 5.0
        bgImageView.layer.masksToBounds = true
        bgImageView.backgroundColor = UIColor.red
        self.contentView.addSubview(bgImageView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: 1)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "1231231231"
        titleLabel.textAlignment = NSTextAlignment.left
        bgImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgImageView).offset(-10)
            make.left.equalTo(bgImageView).offset(10)
            make.width.equalTo(KScreenWidth-20)
            make.height.equalTo(30)
        }
        
        favoriteBtn = UIButton()
        favoriteBtn.setImage(UIImage(named: "Feed_FavoriteIcon_17x17_"), for: .normal)
        favoriteBtn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        favoriteBtn.setTitle(" "+"0"+" ", for: .normal)
        favoriteBtn.layer.cornerRadius = 25/2.0
        favoriteBtn.layer.masksToBounds = true
        //光栅化
        favoriteBtn.layer.rasterizationScale = UIScreen.main.scale
        favoriteBtn.layer.shouldRasterize = true
        bgImageView.addSubview(favoriteBtn)
        favoriteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView).offset(10)
            make.right.equalTo(bgImageView).offset(-10)
            make.height.equalTo(25)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
