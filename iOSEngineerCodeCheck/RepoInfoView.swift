//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepoInfoView: UIViewController {

    
//    表示するリポジトリのデータ
    var repoData: [String:Any] = [:]
    
    
    /// 画像表示部
    lazy var ImgView:UIImageView = {
        var imageView = UIImageView()
//        縦長・横長で分岐
        if self.view.frame.height > self.view.frame.width {
            let len = (self.view.frame.width - 40 < self.view.frame.height / 2) ? self.view.frame.width - 40 : self.view.frame.height / 2 - 40
            imageView.frame = CGRect(x: (self.view.frame.width - len) / 2, y: self.view.frame.height / 2 * 0.7 - (len) / 2, width: len, height: len)
        } else {
            let len = (self.view.frame.height - 100 < self.view.frame.width / 2) ? self.view.frame.height - 100 : self.view.frame.width / 2 - 100
                imageView.frame = CGRect(x: 50, y: self.view.frame.height / 2 - (len) / 2, width: len, height: len)
        }
        return imageView
    }()
    
    /// リポジトリの内容を記載するラベルのグループ化用ビュー
    lazy var LblView:UIView = {
        var view = UIView()
//        縦長・横長で分岐
        if self.view.frame.height > self.view.frame.width {
            view.frame = CGRect(x: ImgView.frame.minX, y: self.view.frame.height / 2 + 100, width: ImgView.frame.width, height: ImgView.frame.height)
        } else {
            view.frame = CGRect(x: self.view.frame.width / 2 + 50, y: ImgView.frame.minY, width: ImgView.frame.width, height: ImgView.frame.height)
        }
        return view
    }()
    
    /// リポジトリタイトル
    lazy var TtlLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.frame = CGRect(x: 0, y: 0, width: LblView.frame.width, height: 40)
        return label
    }()
    
    /// 言語
    lazy var LangLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.frame = CGRect(x: 0, y: TtlLbl.frame.maxY + 10, width: LblView.frame.width, height: 40)
        return label
    }()
    
    /// スター数
    lazy var StrsLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: TtlLbl.frame.maxY + 10, width: LblView.frame.width, height: 40)
        return label
    }()
    
    /// ウォッチ数
    lazy var WchsLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: StrsLbl.frame.maxY, width: LblView.frame.width, height: 40)
        return label
    }()
    
    /// フォーク数
    lazy var FrksLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: WchsLbl.frame.maxY, width: LblView.frame.width, height: 40)
        return label
    }()
    
    /// イシュー数
    lazy var IsssLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: FrksLbl.frame.maxY, width: LblView.frame.width, height: 40)
        return label
    }()
    
    lazy var WebBtn:UIButton = {
       var btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
        btn.setTitle("Webページで開く", for: UIControl.State.normal)
        btn.frame = CGRect(x: LangLbl.frame.minX, y: IsssLbl.frame.maxY, width: LblView.frame.width, height: 40)
        btn.addTarget(self, action: #selector(webBtnPushed), for: .touchUpInside)
        btn.backgroundColor = UIColor.red
        return btn
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         画面回転を検知
        NotificationCenter.default.addObserver(self, selector:#selector(didChangeOrientation(_:)), name: UIDevice.orientationDidChangeNotification,object: nil)
        
        self.view.backgroundColor = UIColor.systemBackground
        
        let repo = repoData

//        画面準備している
        self.view.addSubview(ImgView)
        
        LblView.addSubview(TtlLbl)
        LblView.addSubview(LangLbl)
        LblView.addSubview(StrsLbl)
        LblView.addSubview(WchsLbl)
        LblView.addSubview(FrksLbl)
        LblView.addSubview(IsssLbl)
        LblView.addSubview(WebBtn)
        self.view.addSubview(LblView)
        
//        ラベルのテキスト情報の編集
        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    /// 画面回転時の処理
    @objc private func didChangeOrientation(_ notification: Notification) {
        
        var width = self.view.frame.width
        var height = self.view.frame.height
        if UIDevice.current.orientation.isPortrait { //縦画面の時
            if width > height {
                width = self.view.frame.height
                height = self.view.frame.width
            }
        } else if UIDevice.current.orientation.isLandscape { //横の時
            if height > width {
                width = self.view.frame.height
                height = self.view.frame.width
            }
        }
        
        if height > width {
            let len = (width - 40 < height / 2) ? width - 40 : height / 2 - 40
            ImgView.frame = CGRect(x: (width - len) / 2, y: height / 2 * 0.7 - len / 2, width: len, height: len)
            LblView.frame = CGRect(x: ImgView.frame.minX, y: height / 2 + 100, width: ImgView.frame.width, height: ImgView.frame.height)
        } else {
            let len = (height - 100 < width / 2) ? height - 100 : width / 2 - 100
            ImgView.frame = CGRect(x: 50, y: height / 2 - len / 2, width: len, height: len)
            LblView.frame = CGRect(x: width / 2 + 50, y: ImgView.frame.minY, width: ImgView.frame.width, height: ImgView.frame.height)
        }
        
        ImgView.setNeedsDisplay()
        LblView.setNeedsDisplay()
        
        TtlLbl.frame = CGRect(x: 0, y: 0, width: LblView.frame.width, height: 40)
        TtlLbl.setNeedsDisplay()
        LangLbl.frame = CGRect(x: 0, y: TtlLbl.frame.maxY + 10, width: LblView.frame.width, height: 40)
        LangLbl.setNeedsDisplay()
        StrsLbl.frame = CGRect(x: LangLbl.frame.minX, y: TtlLbl.frame.maxY + 10, width: LblView.frame.width, height: 40)
        StrsLbl.setNeedsDisplay()
        WchsLbl.frame = CGRect(x: LangLbl.frame.minX, y: StrsLbl.frame.maxY, width: LblView.frame.width, height: 40)
        WchsLbl.setNeedsDisplay()
        FrksLbl.frame = CGRect(x: LangLbl.frame.minX, y: WchsLbl.frame.maxY, width: LblView.frame.width, height: 40)
        FrksLbl.setNeedsDisplay()
        IsssLbl.frame = CGRect(x: LangLbl.frame.minX, y: FrksLbl.frame.maxY, width: LblView.frame.width, height: 40)
        IsssLbl.setNeedsDisplay()
        WebBtn.frame = CGRect(x: LangLbl.frame.minX, y: IsssLbl.frame.maxY, width: LblView.frame.width, height: 40)
        WebBtn.setNeedsDisplay()
    }
    
    /// 画像を取得・表示
    func getImage(){
        
        let repo = repoData
        
        TtlLbl.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImgView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
    /// webページを表示するボタン押下時の処理
    @objc func webBtnPushed() {
        let webView = WebView()
        webView.url = repoData["html_url"] as! String
        navigationController?.pushViewController(webView, animated: true)
    }
    
}
