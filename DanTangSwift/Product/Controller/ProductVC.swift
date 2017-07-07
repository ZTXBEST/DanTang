//
//  ProductVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class ProductVC: TXBaseViewController {

    var collecitonView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "单品"
        self.initCollectionView()
        // Do any additional setup after loading the view.
    }
    
    private func initCollectionView() {
        
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
