//
//  ClassifyVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
import SVProgressHUD
class ClassifyVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView?
    var sections : [String]? = ["专题合集","风格","品类"]
    var datas = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initTableView()
        self.requestData()
    }
    
    func requestData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let url = BASE_URL + "v1/collections"
        let params = ["limit": 10,
                      "offset": 0]
        NetworkTool.shared.get(url: url, params: params) { [weak self](success, result, error) in
            
            if success {
                if let data = result?["data"].dictionary {
                    if let collections = data["collections"]?.arrayObject {
                        var datas = [TXSpecialModel]()
                        for item in collections {
                            let post = TXSpecialModel(dict: item as! [String: AnyObject])
                            datas.append(post)
                        }
                        self?.datas.append(datas as AnyObject)
                    }
                }
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let url1 = BASE_URL + "v1/channel_groups/all"
        let params1 = [String: Any]()
        NetworkTool.shared.get(url: url1, params: params1) { (success, result, error) in
            
            if let data = result?["data"].dictionary {
                if let channel_groups = data["channel_groups"]?.arrayObject {
                    for channel_group in channel_groups {
                        var groups = [TXGroupModel]()
                        let channel_group_dict = channel_group as! [String: AnyObject]
                        let channels = channel_group_dict["channels"] as! [AnyObject]
                        for channel in channels {
                            let group = TXGroupModel(dict: channel as! [String: AnyObject])
                            groups.append(group)
                        }
                        self.datas.append(groups as AnyObject)
                    }
                }
            }
            dispatchGroup.leave()
        }
        
        let mainQueue = DispatchQueue.main
        weak var weakSelf = self
        dispatchGroup.notify(queue: mainQueue) {            weakSelf?.tableView?.reloadData()
        }
    }
    
    //MARK:---initView
    fileprivate func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = TXGlobalColor()
        self.view.addSubview(tableView!)
    }
    
    //MARK:---Action
    func buttonClick() {
        let vc = ClassifySeeAllVC()
        vc.title = "查看全部"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:---tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return ClassifySpecialCell.cellHeight()
        }
        else {
            return ClassifyGeneralCell.cellHeight(datas:(self.datas[indexPath.section] as? [TXGroupModel])!)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 40))
        view.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.textColor = UIColor.black
        titleLabel.text = sections?[section]
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.centerY.equalTo(view.height/2)
        }
        
        if section == 0 {
            let button = UIButton()
            button.setTitle("查看全部>", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            view.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.right.equalTo(view).offset(-10)
                make.centerY.equalTo(view.height/2)
            })
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            let ClassifySpecialCellID = "ClassifySpecialCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: ClassifySpecialCellID) as? ClassifySpecialCell
            if cell == nil {
                cell = ClassifySpecialCell(style: .default, reuseIdentifier: ClassifySpecialCellID)
            }
            if self.datas.count>0 {
                cell?.datas = self.datas[indexPath.section] as? [TXSpecialModel]
            }
            return cell!
        }
        else {
            let ClassifyGeneralCellID = "ClassifyGeneralCellID"
            var cell = tableView.dequeueReusableCell(withIdentifier: ClassifyGeneralCellID) as? ClassifyGeneralCell
            if cell == nil {
                cell = ClassifyGeneralCell(style: .default, reuseIdentifier: ClassifyGeneralCellID)
            }
            cell?.datas = self.datas[indexPath.section] as? [TXGroupModel]
            return cell!
        }
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
