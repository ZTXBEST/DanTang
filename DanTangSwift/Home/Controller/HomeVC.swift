//
//  HomeVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class HomeVC: TXBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        requestData()
        initTitlesView()
        // Do any additional setup after loading the view.
    }
    
    private func initNav() {
        navigationItem.rightBarButtonItem=UIBarButtonItem(image: UIImage(named:"Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(rightButtonClick))
        navigationItem.rightBarButtonItem?.tintColor=UIColor.white
    }
    
    private func requestData() {
        
    }
    
    private func initTitlesView() {
        
    }
    
    func rightButtonClick() {
        print("123")
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
