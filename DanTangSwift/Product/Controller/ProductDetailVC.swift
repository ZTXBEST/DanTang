//
//  ProductDetailVC.swift
//  DanTangSwift
//
//  Created by 赵天旭 on 2017/7/12.
//  Copyright © 2017年 ZTX. All rights reserved.
//

import UIKit
import WebKit

class ProductDetailVC: TXBaseViewController,UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate {
    var tableView : UITableView?
    var scrollView : ProductDetailScrollView?
    var footerView : UIView?
    var webView : WKWebView?
    var id_ = Int()
    var data : TXProductDetailModel?

    //分享按钮点击
    func shareBtnItemClick() {
        TXActionSheet.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商品详情"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(shareBtnItemClick))
        navigationItem.rightBarButtonItem?.tintColor=UIColor.white
        self.initTableView()
        self.initHeaderView()
        self.initFooterView()
        self.requsetData()
        // Do any additional setup after loading the view.
    }
    
    private func requsetData() {
        NetworkTool.shared.loadProductDetailData(id: id_) {[weak self] (data) in
            self?.data = data
            self?.scrollView?.model = data
            self?.reloadWebView(index: 0)
        }
    }

    private func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), style: .plain)
        tableView?.backgroundColor = TXGlobalColor()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.view.addSubview(tableView!)
    }
    
    private func initHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 495+10+40))
        headerView.backgroundColor = TXGlobalColor()
        
        scrollView = ProductDetailScrollView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 495))
        scrollView?.backgroundColor = UIColor.white
        headerView.addSubview(scrollView!)
        
        let titleView = UISegmentControllExt(frame: CGRect(x: 0, y: 505, width: KScreenWidth, height: 40))
        titleView.initWithItems(items: ["图文介绍","评论"])
        titleView.backgroundColor = UIColor.white
        titleView.valueChange = { (value) -> () in
            self.reloadWebView(index: value)
        }
        headerView.addSubview(titleView)
        tableView?.tableHeaderView = headerView
    }
    
    private func initFooterView() {
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 200))
        footerView?.backgroundColor = UIColor.white
        
        let jsString = "var meta = document.createElement('meta');"
        + "meta.name = 'viewport';"
        + "meta.content = 'width=device-width, initial-scale=1.0,minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes';"
        + "document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let wkUScript = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 200), configuration: wkWebConfig)
        webView?.scrollView.isScrollEnabled = false
        webView?.clipsToBounds = true
        webView?.isOpaque = false
        webView?.backgroundColor = UIColor.white
        webView?.navigationDelegate = self
        footerView?.addSubview(webView!)
        
        webView?.addObserver(self, forKeyPath: "scrollView.contentSize", options: .new, context: nil)
        tableView?.tableFooterView = footerView
    }
    
    private func reloadWebView(index:Int) {
        if index == 0  {
            let url = data?.url
            let request = NSURLRequest(url: URL(string: url!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20.0)
            webView?.load(request as URLRequest)
        }
    }
    
    //MARK:--- webView
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            webView.height = result as! CGFloat
            self.footerView?.height = webView.height
            self.tableView?.tableFooterView = self.footerView
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath=="scrollView.contentSize" {
            webView?.height = (webView?.scrollView.contentSize.height)!
            self.footerView?.height=(webView?.height)!
            self.tableView?.tableFooterView=footerView
        }
    }
    
    
    //MARK:--- TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
