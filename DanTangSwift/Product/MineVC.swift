//
//  MineVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
import SVProgressHUD

class MineVC: TXBaseViewController,UITableViewDataSource,UITableViewDelegate {

    var cellCount = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabelView()
    }
    
    /// 创建 tableView
    private func initTabelView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    private lazy var headerView: MineHeaderView = {
        let headerView = MineHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 200)
        headerView.iconButton.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
        headerView.messageButton.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
        headerView.settingButton.addTarget(self, action: #selector(settingButtonClick), for: .touchUpInside)
        return headerView
    }()
    
    // MARK: - 头部按钮点击
    func iconButtonClick() {
        SVProgressHUD.showInfo(withStatus: "该跳登陆了")
    }
    
    func messageButtonClick() {
        SVProgressHUD.showInfo(withStatus: "该跳消息了")
    }
    
    func settingButtonClick() {
        SVProgressHUD.showInfo(withStatus: "该跳设置了")
    }
    
    private lazy var footerView: MineFooterView = {
        let footerView = MineFooterView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 200))
        return footerView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let choiceView = UISegmentControllExt(frame: CGRect(x: 0, y: 505, width: KScreenWidth, height: 40))
        choiceView.initWithItems(items: ["喜欢的商品","喜欢的专题"])
        choiceView.backgroundColor = UIColor.white
        choiceView.valueChange = { (value) -> () in
        }
        return choiceView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = 200 - offsetY
            headerView.bgImageView.frame = tempFrame
        }
    }
}
