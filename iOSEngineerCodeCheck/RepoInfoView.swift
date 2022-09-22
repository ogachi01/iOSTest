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
            imageView.frame = CGRect(x: 20, y: self.view.frame.height / 2 * 0.7 - (self.view.frame.width - 40) / 2, width: self.view.frame.width - 40, height: self.view.frame.width - 40)
        } else {
            imageView.frame = CGRect(x: 50, y: self.view.frame.height / 2 - (self.view.frame.height - 100) / 2, width: self.view.frame.height - 100, height: self.view.frame.height - 100)
        }
        return imageView
    }()
    
    /// リポジトリの内容を記載するラベルのグループ化用ビュー
    lazy var LblView:UIView = {
        var view = UIView()
//        縦長・横長で分岐
        if self.view.frame.height > self.view.frame.width {
            view.frame = CGRect(x: 20, y: self.view.frame.height / 2 * 0.7 + (self.view.frame.width - 40) / 2, width: ImgView.frame.width, height: ImgView.frame.height)
        } else {
            view.frame = CGRect(x: self.view.frame.width / 2 + 50, y: self.view.frame.height / 2 - (self.view.frame.height - 100) / 2, width: ImgView.frame.width, height: ImgView.frame.height)
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
        
        if self.view.frame.height > self.view.frame.width {
            ImgView.frame = CGRect(x: 20, y: self.view.frame.height / 2 * 0.7 - (self.view.frame.width - 40) / 2, width: self.view.frame.width - 40, height: self.view.frame.width - 40)
            LblView.frame = CGRect(x: 20, y: self.view.frame.height / 2 * 0.7 + (self.view.frame.width - 40) / 2, width: ImgView.frame.width, height: ImgView.frame.height)
        } else {
            ImgView.frame = CGRect(x: 50, y: self.view.frame.height / 2 - (self.view.frame.height - 100) / 2, width: self.view.frame.height - 100, height: self.view.frame.height - 100)
            LblView.frame = CGRect(x: self.view.frame.width / 2 + 50, y: self.view.frame.height / 2 - (self.view.frame.height - 100) / 2, width: ImgView.frame.width, height: ImgView.frame.height)
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
    
}
