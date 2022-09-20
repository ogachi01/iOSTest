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
    
    lazy var ImgView:UIImageView = {
        var imageView = UIImageView()
        imageView.frame = CGRect(x: 20, y: self.view.frame.height / 2 * 0.7 - (self.view.frame.width - 40) / 2, width: self.view.frame.width - 40, height: self.view.frame.width - 40)
        return imageView
    }()
    
    lazy var TtlLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.frame = CGRect(x: ImgView.frame.minX, y: ImgView.frame.maxY + 28, width: ImgView.frame.width, height: 40)
        return label
    }()
    
    lazy var LangLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.frame = CGRect(x: ImgView.frame.minX, y: TtlLbl.frame.maxY + 10, width: ImgView.frame.width, height: 40)
        return label
    }()
    
    lazy var StrsLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: TtlLbl.frame.maxY + 10, width: ImgView.frame.width, height: 40)
        return label
    }()
    
    lazy var WchsLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: StrsLbl.frame.maxY, width: ImgView.frame.width, height: 40)
        return label
    }()
    
    lazy var FrksLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: WchsLbl.frame.maxY, width: ImgView.frame.width, height: 40)
        return label
    }()
    
    lazy var IsssLbl:UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.frame = CGRect(x: LangLbl.frame.minX, y: FrksLbl.frame.maxY, width: ImgView.frame.width, height: 40)
        return label
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemBackground
        
        let repo = repoData
        
        self.view.addSubview(ImgView)
        self.view.addSubview(TtlLbl)
        self.view.addSubview(LangLbl)
        self.view.addSubview(StrsLbl)
        self.view.addSubview(WchsLbl)
        self.view.addSubview(FrksLbl)
        self.view.addSubview(IsssLbl)
        
        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
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
