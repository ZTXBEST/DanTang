//
//  ProductDetailVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/12.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class ProductDetailVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView : UITableView?
    var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        self.initHeaderView()
        // Do any additional setup after loading the view.
    }

    private func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: KScreenWidth, height: KScreenHeight), style: .plain)
        tableView?.backgroundColor = TXGlobalColor()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.view.addSubview(tableView!)
    }
    
    private func initHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 520))
        headerView.backgroundColor = UIColor.white

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 375))
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.red
        headerView.addSubview(scrollView)
        
        headerView.addSubview(self.titleLabel)
        headerView.addSubview(self.priceLabel)
        headerView.addSubview(self.descriptionLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom)
            
        }
        
        tableView?.tableHeaderView = headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    //MARK:--- 懒加载
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
