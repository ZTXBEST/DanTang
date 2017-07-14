//
//  TXActionSheet.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/14.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class TXActionSheet: UIView {

    class func show() {
        let actionSheet = TXActionSheet()
        actionSheet.frame = UIScreen.main.bounds
        actionSheet.backgroundColor = TXColor(r: 0, g: 0, b: 0, a: 0.6)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(actionSheet)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    func initView() {
        addSubview(bgView)
        
        // 上部 分享界面
        bgView.addSubview(topView)
        // 下部取消按钮
        bgView.addSubview(cancelButton)
        // 分享到 标签
        topView.addSubview(shareLabel)
        // 6 个分享按钮的 view
        topView.addSubview(shareButtonView)
        
        topView.snp.makeConstraints { (make) in
            make.bottom.equalTo(cancelButton.snp.top).offset(-kMargin)
            make.left.equalTo(cancelButton.snp.left)
            make.right.equalTo(cancelButton.snp.right)
            make.height.equalTo(230)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(kMargin)
            make.right.bottom.equalTo(bgView).offset(-kMargin)
            make.height.equalTo(44)
        }
        
        shareLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(topView)
            make.height.equalTo(30)
        }
    }
    
    // 底部 view
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: KScreenHeight, width: KScreenWidth, height: 280)
        return bgView
    }()
    // 上部 view
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        topView.layer.cornerRadius = 5.0
        topView.layer.masksToBounds = true
        return topView
    }()
    
    // 分享到标签
    private lazy var shareLabel: UILabel = {
        let shareLabel = UILabel()
        shareLabel.text = "分享到"
        shareLabel.textColor = TXColor(r: 0, g: 0, b: 0, a: 0.7)
        shareLabel.textAlignment = .center
        return shareLabel
    }()
    // 6个按钮
    private lazy var shareButtonView: TXShareButtonView = {
        let shareButtonView = TXShareButtonView()
        shareButtonView.frame = CGRect(x: 0, y: 30, width: KScreenWidth - 20, height: 230 - 30)
        return shareButtonView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.setTitleColor(TXColor(r: 37, g: 142, b: 240, a: 1.0), for: .normal)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.layer.masksToBounds = true
        return cancelButton
    }()
    
    func cancelButtonClick() {
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.y = KScreenHeight
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.y = KScreenHeight
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: 0.25) {
            self.bgView.y = KScreenHeight - self.bgView.height
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
