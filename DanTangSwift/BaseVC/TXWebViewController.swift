//
//  TXWebViewController.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/7.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
import SVProgressHUD

class TXWebViewController: TXBaseViewController ,UIWebViewDelegate{
    
    var url = String()
    var titleString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView()
        webView.frame = view.bounds
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        let request = URLRequest(url: URL(string: url)!)
        webView.loadRequest(request)
        webView.delegate = self
        view.addSubview(webView)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.showInfo(withStatus: "正在加载中...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
}
