//
//  HomeVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class HomeVC: TXBaseViewController {
    var channels = [TXHomeTopModel]()
    //选中的标签
    var selectButton = UIButton()
    //底部红色指示器
    weak var indicatorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        requestData()
        // Do any additional setup after loading the view.
    }
    
    private func initNav() {
        navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(rightButtonClick))
        navigationItem.rightBarButtonItem?.tintColor=UIColor.white
    }
    
    private func requestData() {
        weak var weakSelf = self
        NetworkTool.shared.loadHomeTopData { (datas) in
            weakSelf?.channels = datas
            weakSelf?.initTitlesView()
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
        
        //右侧箭头
        let arrowBtn = UIButton()
        arrowBtn.frame=CGRect(x: KScreenWidth-kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
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

    func titlesClick(button:UIButton) {
        selectButton.isEnabled = true
        button.isEnabled = false
        selectButton = button
        UIView.animate(withDuration: 0.25) {
            self.indicatorView?.width = self.selectButton.width
            self.indicatorView?.centerX = self.selectButton.centerX
        }
    }
    
    func rightButtonClick() {
        print("123")
    }
    
    func arrowBtnClick(sender:UIButton){
        sender.isSelected = !sender.isSelected
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
