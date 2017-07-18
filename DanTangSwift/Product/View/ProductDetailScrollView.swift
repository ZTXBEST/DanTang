//
//  ProductDetailScrollView.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/13.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class ProductDetailScrollView: UIView,UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var data : [String]?
    var pageViews = [UIImageView]()
    var currentArray = [AnyObject]()
    var currentIndex : Int = 0
    var timer : Timer?
    
    
    var model : TXProductDetailModel? {
        didSet {
            self.timer?.fireDate = NSDate.distantPast
            data = model?.image_urls!
            titleLabel.text = model?.name
            priceLabel.text = model?.price
            descriptionLabel.text = model?.describe
            
//            for i in 0..<Int((model?.image_urls?.count)!) {
//                let imageView = UIImageView(frame: CGRect(x: CGFloat(i*Int(scrollView.width)), y: 0, width: KScreenWidth, height: scrollView.height))
//                let url = model?.image_urls?[i]
//                imageView.kf.setImage(with: URL(string:url!))
//                scrollView.addSubview(imageView)
//            }
//            scrollView.contentSize = CGSize(width:CGFloat((model?.image_urls?.count)!)*scrollView.width, height: scrollView.height)
            pageControl.numberOfPages = (model?.image_urls?.count)!
            self.currentIndex = 0
            self.startTimer()
            self.resetScrollView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 375))
        scrollView.delegate = self
        scrollView.backgroundColor = TXGlobalColor()
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        for i in 0..<3 {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i*Int(scrollView.width)), y: 0, width: KScreenWidth, height: scrollView.height))
            scrollView.addSubview(imageView)
            pageViews.append(imageView)
        }
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.centerX)
            make.centerY.equalTo(scrollView.snp.bottom).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
        
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(20)
            make.width.equalTo(KScreenWidth-20)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(20)
            make.width.equalTo(KScreenWidth-20)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(50)
            make.width.equalTo(KScreenWidth-20)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    func startTimer() {
        timer?.fireDate = NSDate.distantPast
    }
    
    func nextImage() {
        scrollView.setContentOffset(CGPoint(x: scrollView.width*2, y: 0), animated: true)
    }
    
    //MARK:--- scrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.fireDate = NSDate.distantFuture
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        开启定时器
        NSObject.cancelPreviousPerformRequests(withTarget: self.timer!, selector: #selector(getter: timer?.fireDate), object: NSDate.distantPast)
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) { 
            weakSelf?.startTimer()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        if (offsetX>=2*self.width) {
            self.currentIndex+=1
            if self.currentIndex>=(data?.count)! {
                self.currentIndex=0
            }
            self.resetScrollView()
        }
        if offsetX<=0 {
            self.currentIndex = self.currentIndex-1
            if self.currentIndex<0 {
                self.currentIndex=(self.data?.count)!-1
            }
            self.resetScrollView()
        }
    }
    
    func resetScrollView() {
        if (data?.count)!<=0 {
            return
        }
        
        if (data?.count)!<2{
            scrollView.contentSize = CGSize(width: KScreenWidth, height: scrollView.height)
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            timer?.fireDate = NSDate.distantFuture
            let imageView = pageViews[0]
            let url = data?[0]
            imageView.kf.setImage(with: URL(string: url!))
            return
        }
        else if data?.count==2 {
            if (currentArray.count)>0 {
                currentArray.removeAll()
            }
            if self.currentIndex==0 {
                currentArray.append(data?.last as AnyObject)
                currentArray.append(data?[self.currentIndex] as AnyObject)
                currentArray.append(data?.last as AnyObject)
            }
            else {
                currentArray.append(data?.first as AnyObject)
                currentArray.append(data?[self.currentIndex] as AnyObject)
                currentArray.append(data?.first as AnyObject)
            }
        }
        else {
            if (currentArray.count)>0 {
                currentArray.removeAll()
            }
            if self.currentIndex==0 {
                currentArray.append(data?.last as AnyObject)
                currentArray.append(data?[self.currentIndex] as AnyObject)
                currentArray.append(data?[self.currentIndex+1] as AnyObject)
            }
            else if self.currentIndex>=(data?.count)!-1{
                currentArray.append(data?[self.currentIndex-1] as AnyObject)
                currentArray.append(data?[self.currentIndex] as AnyObject)
                currentArray.append(data?.first as AnyObject)
            }
            else {
                currentArray.append(data?[self.currentIndex-1] as AnyObject)
                currentArray.append(data?[self.currentIndex] as AnyObject)
                currentArray.append(data?[self.currentIndex+1] as AnyObject)
            }
        }
        
        for i in 0..<3 {
            let imageView = pageViews[i]
            let url = currentArray[i] as? String
            imageView.kf.setImage(with: URL(string: url!))
        }
        
        scrollView.contentSize = CGSize(width: CGFloat((currentArray.count))*KScreenWidth, height: scrollView.height)
        scrollView.contentOffset = CGPoint(x: KScreenWidth, y: 0)
        pageControl.currentPage = self.currentIndex
    }
    
    //MARK:--- 懒加载
    //pageControl
    private lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    //标题
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    //价格
    private lazy var priceLabel : UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = TXGlobalRedColor()
        priceLabel.numberOfLines = 0
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        return priceLabel
    }()
    //描述
    private lazy var descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = TXColor(r: 0, g: 0, b: 0, a: 0.6)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        return descriptionLabel
    }()
    
    //析构 类似delloc方法
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
}
