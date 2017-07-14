//
//  ProductVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

private let cellId = "collectionViewId"

class ProductVC: TXBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionView : UICollectionView?
    var datas = [TXProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCollectionView()
        self.requestData()
        // Do any additional setup after loading the view.
    }
    
    private func requestData() {

        NetworkTool.shared.loadProductData {[weak self] (data) in
            self?.datas = data
            self?.collectionView?.reloadData()
        }
    }
    
    private func initCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        let width: CGFloat = (KScreenWidth - 20) / 2
        let height: CGFloat = 245
        layout.itemSize = CGSize(width: width, height: height)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.frame = view.bounds
        collectionView?.backgroundColor = view.backgroundColor
        view.addSubview(collectionView!)
                
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.model = datas[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = datas[indexPath.row]
        let vc = ProductDetailVC()
        vc.id_ = model.id!
        self.navigationController?.pushViewController(vc, animated: true)
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
