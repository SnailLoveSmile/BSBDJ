//
//  MeWebViewController.swift
//  BSBDJ
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit
import WebKit
class MeWebViewController: UIViewController {



    var urlString: String!
    var btnTitle = ""
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = btnTitle
        guard let url = URL(string: urlString) else {
            return
        }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.scrollView.showsVerticalScrollIndicator = false
    }
}

extension MeWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("网络请求失败")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网络数据加载完毕")
    }


    
}

