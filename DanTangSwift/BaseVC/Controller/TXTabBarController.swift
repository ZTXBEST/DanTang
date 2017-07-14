//
//  TXTabBarController.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit

class TXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = TXColor(r: 245, g: 90, b: 93, a: 1/0)
        addChildViewControllers()
        // Do any additional setup after loading the view.
    }

    private func addChildViewControllers() {
        addChildViewController(childController: HomeVC(), title: "单糖", imaged: "TabBar_home_23x23_")
        addChildViewController(childController: ProductVC(), title: "单品", imaged: "TabBar_gift_23x23_")
        addChildViewController(childController: ClassifyVC(), title: "分类", imaged: "TabBar_category_23x23_")
        addChildViewController(childController: MineVC(), title: "我的", imaged: "TabBar_me_boy_23x23_")
    }
    
    private func addChildViewController(childController:UIViewController,title:String,imaged:String) {
//        childController.tabBarItem.title=title
        childController.title = title
        childController.tabBarItem.image=UIImage(named:imaged)
        childController.tabBarItem.selectedImage=UIImage(named:imaged+"selected")
        let nav=TXNavigationController(rootViewController: childController)
        addChildViewController(nav)
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
