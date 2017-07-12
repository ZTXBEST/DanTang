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
    var webView = UIWebView()
    var url = String()
    var titleString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configToolBar()
        webView = UIWebView()
        webView.frame = view.bounds
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        let request = URLRequest(url: URL(string: url)!)
        webView.loadRequest(request)
        webView.delegate = self
        view.addSubview(webView)
    }
    
    func configToolBar() {
        let backItem = UIBarButtonItem(image: UIImage(named:"checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(backButtonClick))
        
        let flexItem0 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let forwardItem = UIBarButtonItem(image: UIImage(named: "Category_PostCollectionSeeAll_nightMode_5x8_"), style: .plain, target: nil, action: nil)
    
        let flexItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
      self.setToolbarItems([backItem,flexItem0,forwardItem,flexItem1], animated: true)
    }
    // MARK:-- webview的方法
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
    
    //MARK:-- button Action
    @objc private func backButtonClick() {
        if (self.webView.canGoBack) {
            self.webView.goBack()
        }
    }
}
