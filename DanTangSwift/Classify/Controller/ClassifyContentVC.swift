//
//  ClassifyContentVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/18.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "cellIdentifier"
class ClassifyContentVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var id = NSInteger()
    var tableView = UITableView()
    var datas = [TXHomeModel]()
    var type = ClassifyContentVCType.ClassifyProject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化tableView
        self.initContentView()
        self.requestData()
    }
    
    func requestData() {
        weak var weakSelf = self
        switch type {
        case .ClassifyProject:
            let url = BASE_URL + "v1/collections/\(id)/posts"
            let params = ["gender": 1,
                          "generation": 1,
                          "limit": 20,
                          "offset": 0]
            NetworkTool.shared.get(url: url, params: params) { (success, result, error) in
                
                if let data = result?["data"].dictionary {
                    if let postsData = data["posts"]?.arrayObject {
                        var posts = [TXHomeModel]()
                        for item in postsData {
                            let post = TXHomeModel(dict: item as! [String: AnyObject])
                            posts.append(post)
                        }
                        self.datas = posts
                    }
                }
                weakSelf?.tableView.reloadData()
            }
            break
            
            
        case .ClassifyOthers:
            let url = BASE_URL + "v1/channels/\(id)/items"
            let params = ["limit": 20,
                          "offset": 0]
            NetworkTool.shared.get(url: url, params: params) { (success, result, error) in
                
                if let data = result?["data"].dictionary {
                    if let itemsData = data["items"]?.arrayObject {
                        var items = [TXHomeModel]()
                        for item in itemsData {
                            let post = TXHomeModel(dict: item as! [String: AnyObject])
                            items.append(post)
                        }
                        self.datas = items
                    }
                }
                weakSelf?.tableView.reloadData()
            }
            break
        }
    }
    
    //MARK: - init方法
    private func initContentView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none;
        tableView.backgroundColor = TXGlobalColor()
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? HomeCell
        if cell == nil {
            cell = HomeCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.homeModel = self.datas[indexPath.row]
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
