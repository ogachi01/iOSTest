//
//  WebView.swift
//  iOSEngineerCodeCheck
//
//  Created by 小川拓也 on 2022/09/27.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebView: UIViewController, UIWebViewDelegate, WKNavigationDelegate{

//    var webView: WKWebView?
    var url:String = ""
    
    lazy var WebView:WKWebView = {
        var webView = WKWebView()
        webView.navigationDelegate = self
        webView.frame = CGRect(x: 0, y: SearchView().topHeight, width: self.view.frame.width, height: self.view.frame.height - SearchView().topHeight - additionalSafeAreaInsets.bottom)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            self.view.backgroundColor = .white
        }
        
//         画面回転を検知
        NotificationCenter.default.addObserver(self, selector:#selector(didChangeOrientation(_:)), name: UIDevice.orientationDidChangeNotification,object: nil)

        self.view.addSubview(WebView)
        let req = NSURLRequest(url: URL(string: url)!)
        self.WebView.load(req as URLRequest)
    }
    
    /// 画面回転検出時に実行
    @objc private func didChangeOrientation(_ notification: Notification) {

        var width = self.view.frame.width
        var height = self.view.frame.height
        if UIDevice.current.orientation.isPortrait { //縦画面の時
            if width > height {
                width = self.view.frame.height
                height = self.view.frame.width
            }
        } else { //横の時
            if height > width {
                width = self.view.frame.height
                height = self.view.frame.width
            }
        }
        
        WebView.frame = CGRect(x: 0, y: SearchView().topHeight, width: width, height: height - SearchView().topHeight - additionalSafeAreaInsets.bottom)
        WebView.setNeedsDisplay()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

