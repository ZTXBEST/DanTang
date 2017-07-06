//
//  NetworkTool.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/5.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NetworkTool: NSObject {
    ///swift 单行单例
    static let shared = NetworkTool()
    
    
    func loadHomeTopData(finished:@escaping (_ channel:[TXHomeTopModel]) -> ()) {
        let url = BASE_URL+"v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        Alamofire
            .request(url,parameters:params)
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let value = response.result.value {
                print(response.result.value as Any)
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                
                let data = dict["data"].dictionary
//                if let channles = data?["channels"]?.arrayObject
                //确定channels不为空，用！强制拆包
                if let channles = data!["channels"]?.arrayObject {
                    var tx_channels = [TXHomeTopModel]()
                    for channle in channles {
                        let tx_channel = TXHomeTopModel(dict:channle as! [String : AnyObject])
                        tx_channels .append(tx_channel)
                    }
                    finished(tx_channels)
                }
            }
        }
    }
    
    
    ///获取首页数据
    func loadHomeInfo(id: Int , finished:@escaping (_ homeModel:[TXHomeModel]) -> ()) {
        
        let url = BASE_URL + "channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0
                      ]
        Alamofire.request( url,
                           parameters: params)
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            print(response)
            
//            if let value = response.result.value {
//                let dict = value
//            }
        }
        
    }
}
