//
//  ClassifyGeneralCell.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/18.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

let cellID = "ClassifyCollectionViewCellID"

class ClassifyGeneralCell: UITableViewCellExt,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionView : UICollectionView?
    
    var model = [TXGroupModel]()
    
    var datas :[TXGroupModel]? {
        didSet {
            if (datas != nil) && (datas?.count)!>0 {
                model = datas!
                self.refreshCollectionView()
                self.collectionView?.reloadData()
            }
        }
    }
    
    fileprivate func refreshCollectionView() {
        self.collectionView?.height = ClassifyGeneralCell.cellHeight(datas: model)
    }
    
    override func initView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 100), collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isScrollEnabled = false
        self.contentView.addSubview(collectionView!)
        
        collectionView?.register(ClassifyCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ClassifyCollectionViewCell
        cell.model = model[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = datas?[indexPath.row]
        let vc = ClassifyContentVC()
        vc.id = (model?.id!)!
        vc.title = model?.name
        vc.type = ClassifyContentVCType.ClassifyOthers
        APPConfig.getCurrentNav()?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (KScreenWidth-50)/4, height: (KScreenWidth-50)/4+30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }
    
     class func cellHeight(datas :[TXGroupModel]) ->CGFloat {
        if datas.count<=4 {
            return (KScreenWidth-50)/4+30
        }
        else {
            return ceil(CGFloat(Double(datas.count)/4))*((KScreenWidth-50)/4+30+2*kMargin)
        }
    }
}
