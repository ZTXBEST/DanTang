//
//  HomeVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class HomeVC: TXBaseViewController,UIScrollViewDelegate {
    var channels = [TXHomeTopModel]()
    //选中的标签
    weak var selectButton = UIButton()
    //底部红色指示器
    weak var indicatorView = UIView()
    //主页scrollview
    weak var contentView = UIScrollView()
    weak var titlesView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        requestData()
        // Do any additional setup after loading the view.
    }
//    MARK:- init方法
    private func initNav() {
        navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(rightButtonClick))
        navigationItem.rightBarButtonItem?.tintColor=UIColor.white
    }
    
    //主页的scrollView
    private func initScrollView() {
        let contentView = UIScrollView()
        automaticallyAdjustsScrollViewInsets = false
        contentView.frame = view.bounds
        contentView.contentSize = CGSize(width: contentView.width*CGFloat(channels.count), height: contentView.height)
        contentView.delegate = self
        contentView.isPagingEnabled = true
        view.insertSubview(contentView, at: 0)
        self.contentView = contentView
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    private func requestData() {
        weak var weakSelf = self
        NetworkTool.shared.loadHomeTopData { (datas) in
            weakSelf?.channels = datas
            for channel in datas {
                let vc = HomeContentVC()
                vc.title = channel.name
                vc.type = channel.id!
                weakSelf!.addChildViewController(vc)
            }
            weakSelf?.initTitlesView()
            weakSelf?.initScrollView()
        }
    }
    
    // 顶部标签
    private func initTitlesView() {
        // 顶部view
        let bgView = UIView()
        bgView.frame=CGRect(x: 0, y: kTitlesViewY, width:KScreenWidth, height: kTitlesViewH)
        view.addSubview(bgView)
        
        //标签view
        let titlesView = UIView()
        titlesView.frame=CGRect(x: 0, y: 0, width:KScreenWidth-kTitlesViewH, height: kTitlesViewH)
        titlesView.backgroundColor=TXGlobalColor()
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        
        //右侧箭头
        let arrowBtn = UIButton()
        arrowBtn.frame=CGRect(x: KScreenWidth-kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowBtn.backgroundColor=TXGlobalColor()
        arrowBtn.setImage(UIImage(named: "arrow_index_down_8x4_"), for: .normal)
        arrowBtn.setImage(UIImage(named: "arrow_index_up_8x4_"), for: .selected)
        arrowBtn.addTarget(self, action: #selector(arrowBtnClick(sender:)), for: .touchUpInside)
        bgView.addSubview(arrowBtn)
        
        //底部滑动view
        let indicatorView = UIView()
        indicatorView.backgroundColor = TXGlobalRedColor()
        indicatorView.height = 2
        indicatorView.y = kTitlesViewH - 2
        self.indicatorView = indicatorView
        indicatorView.tag = -1
        
        let count = channels.count
        let width = titlesView.width / CGFloat(count)
        let height = titlesView.height
        
        for index in 0..<count {
            let channel = channels[index]
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index)*width;
            button.tag = index
            button.setTitle(channel.name, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.setTitleColor(TXGlobalRedColor(), for: .disabled)
            button.addTarget(self, action: #selector(titlesClick(button:)), for: .touchUpInside)
            titlesView.addSubview(button)
            
            if index==0 {
                button.isEnabled = false
                selectButton = button
                indicatorView.width = button.width
                indicatorView.centerX = button.centerX
            }
        }
        titlesView.addSubview(indicatorView)
    }
//MARK:- button Action
    func titlesClick(button:UIButton) {
        selectButton?.isEnabled = true
        button.isEnabled = false
        selectButton = button
        UIView.animate(withDuration: 0.25) {
            self.indicatorView?.width = (self.selectButton?.width)!
            self.indicatorView?.centerX = (self.selectButton?.centerX)!
        }
        //滚动,切换子控制器
        var offset = contentView?.contentOffset
        offset?.x = CGFloat(button.tag) * (contentView?.width)!
        contentView?.setContentOffset(offset!, animated: true)
    }
    
    func rightButtonClick() {
        print("123")
    }
    
    func arrowBtnClick(sender:UIButton){
        sender.isSelected = !sender.isSelected
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.width)
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 点击 Button
        let button = titlesView?.subviews[index]
        self.titlesClick(button: button as! UIButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
