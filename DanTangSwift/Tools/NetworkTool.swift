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

//重新封装网络请求。
typealias NetworkFinished = (_ success :Bool, _ result:JSON?, _ error:NSError?) -> ()

extension NetworkTool {
    /// get
    ///
    /// - Parameters:
    ///   - url: urlString
    ///   - params: 参数
    ///   - finished: 完成回调
    func get(url:String, params:[String : Any], finished:@escaping NetworkFinished) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show(withStatus: "正在加载中")
        Alamofire
            .request(url, method: .get, parameters: params, headers: nil).responseJSON {[weak self] (response) in
                print("url:",response.response?.url as Any,"\n",response.result.value as Any)
                self?.handle(response: response, finished: finished)
        }
    }
    
    /// post
    ///
    /// - Parameters:
    ///   - url: urlString
    ///   - params: 参数
    ///   - finished: 完成回调
    func post(url:String, params:[String : Any], finished:@escaping NetworkFinished) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show(withStatus: "正在加载中")
        Alamofire
            .request(url, method: .post, parameters: params, headers: nil).responseJSON {[weak self] (response) in
                print("url:",response.response?.url as Any,"\n",response.result.value as Any)
                self?.handle(response: response, finished: finished)
        }
    }
    
    /// 处理响应结果
    ///   - response: 响应对象
    ///   - finished: 完成回调
    fileprivate func handle(response :DataResponse<Any>,finished:@escaping NetworkFinished) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        switch response.result
        {
            
        case .success(let value):
            let json = JSON(value)
            SVProgressHUD.dismiss()
            finished(true, json, nil)
            break
            
        case .failure(let error):
            SVProgressHUD.showError(withStatus: "请求失败，请重试")
            finished(false,nil,error as NSError?)
            break
            
        }
    }
}

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
        
        //单品详情
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
        
        /// 顶部 专题合集 -> 专题列表
        func loadSpecialData(id: Int, finished:@escaping (_ posts: [TXSpecialModel]) -> ()) {
            SVProgressHUD.show(withStatus: "正在加载...")
            let url = BASE_URL + "v1/collections/\(id)/posts"
            let params = ["gender": 1,
                          "generation": 1,
                          "limit": 20,
                          "offset": 0]
            Alamofire
                .request(url, parameters: params)
                .responseJSON { (response) in
                    guard response.result.isSuccess else {
                        SVProgressHUD.show(withStatus: "加载失败...")
                        return
                    }
                    if let value = response.result.value {
                        let dict = JSON(value)
                        let code = dict["code"].intValue
                        let message = dict["message"].stringValue
                        guard code == RETURN_OK else {
                            SVProgressHUD.show(withStatus: message)
                            return
                        }
                        SVProgressHUD.dismiss()
                        if let data = dict["data"].dictionary {
                            if let postsData = data["posts"]?.arrayObject {
                                var posts = [TXSpecialModel]()
                                for item in postsData {
                                    let post = TXSpecialModel(dict: item as! [String: AnyObject])
                                    posts.append(post)
                                }
                                finished(posts)
                            }
                        }
                    }
            }
        }
}
