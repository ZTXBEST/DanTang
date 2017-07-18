//
//  ClassifySeeAllVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/18.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

let ClassifySeeAllCellID = "ClassifySeeAllCellID"

class ClassifySeeAllVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var datas = [TXClassifySeeAllModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none;
        tableView.backgroundColor = TXGlobalColor()
        view.addSubview(tableView)
        let nib = UINib(nibName: String(describing: ClassifySeeAllCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ClassifySeeAllCellID)
        tableView.rowHeight = 160

        
        self.requestData()
    }
    
    fileprivate func requestData() {
        let url = BASE_URL + "v1/collections"
        let params = ["limit": 20,
                      "offset": 0]
        NetworkTool.shared.get(url: url, params: params) {[weak self] (success, result, error) in
            
            if let data = result?["data"].dictionary {
                if let collectionsData = data["collections"]?.arrayObject {
                    var collections = [TXClassifySeeAllModel]()
                    for item in collectionsData {
                        let collection = TXClassifySeeAllModel(dict: item as! [String: AnyObject])
                        collections.append(collection)
                    }
                    self?.datas = collections
                }
            }
            self?.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassifySeeAllCellID) as! ClassifySeeAllCell
        cell.collection = datas[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = datas[indexPath.row]
        let vc = ClassifyContentVC()
        vc.id = model.id!
        vc.title = model.title
        vc.type = ClassifyContentVCType.ClassifyProject
        navigationController?.pushViewController(vc, animated: true)
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
