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
        SVProgressHUD.show()
        Alamofire
            .request(url,parameters:params)
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let value = response.result.value {
                print("url:",response.response?.url as Any,"\n",response.result.value as Any)
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
        
        let url = BASE_URL + "/v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0
                      ]
        SVProgressHUD.show()
        Alamofire.request( url,
                           parameters: params)
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            print("url:",response.response?.url as Any,"\n",response.result.value as Any)
            
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
                if let items = data?["items"]?.arrayObject {
                    var tx_itmes = [TXHomeModel]()
                    for item in items {
                        let tx_item = TXHomeModel(dict: item as! [String : AnyObject])
                        tx_itmes.append(tx_item)
                    }
                    finished(tx_itmes)
                }
            }
        }
    }
    
    //获取单品页数据
    func loadProductData(finished:@escaping (_ productModel:[TXProductModel]) -> ()) {
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        SVProgressHUD.show()
        Alamofire
            .request(url,parameters:params)
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                print("url:",response.response?.url as Any,"\n",response.result.value as Any)
                
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
                    if let items = data?["items"]?.arrayObject {
                        var products = [TXProductModel]()
                        for item in items {
                            let itemDict = item as! [String : AnyObject]
                            if let itemData = itemDict["data"] {
                                let product = TXProductModel(dict: itemData as! [String: AnyObject])
                                products.append(product)
                            }
                        }
                        finished(products)
                    }
                }
        }
        
    }
    
    func loadProductDetailData(id: Int , finished:@escaping (_ productDetailModel:TXProductDetailModel)->()) {
        let url = BASE_URL + "v2/items/\(id)"
        SVProgressHUD.show(withStatus: "正在加载中...")
        Alamofire
            .request(url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                print("url:",response.response?.url as Any,"\n",response.result.value as Any)
                
                
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
                    if let data = dict["data"].dictionaryObject {
                        let productDetail = TXProductDetailModel(dict: data as [String : AnyObject])
                        finished(productDetail)
                    }
                }
                
        }
    }
    
}
