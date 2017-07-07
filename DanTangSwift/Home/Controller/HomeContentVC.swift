//
//  HomeContentVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/7.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

private let homeCellID = "homeCellID"

class HomeContentVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var type = NSInteger()
    var tableView = UITableView()
    var datas = [TXHomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化tableView
        self.initContentView()
        self.requestData()
    }
    
    func requestData() {
        weak var weakSelf = self
        NetworkTool.shared.loadHomeInfo(id: type) { (datas) in
            weakSelf?.datas = datas
            weakSelf?.tableView.reloadData()
        }
    }
    
    //MARK: - init方法
    private func initContentView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
       tableView.separatorStyle = .none;
        tableView.backgroundColor = TXGlobalColor()
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as? HomeCell
        if cell == nil {
            cell = HomeCell(style: .default, reuseIdentifier: homeCellID)
        }
        cell?.homeModel = datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = datas[indexPath.row]
        let vc = TXWebViewController()
        vc.url = model.content_url!
        vc.title = "攻略详情"
        navigationController?.pushViewController(vc, animated: true)
    }
}
