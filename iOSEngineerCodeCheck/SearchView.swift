//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchView:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    var repo: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String!
    var url: String!
    
    /// 検索バー
    lazy var SchBr: UISearchBar = {
        let SearchBar = UISearchBar()
        SearchBar.text = "GitHubのリポジトリを検索できるよー"
        SearchBar.delegate = self
        SearchBar.frame = CGRect(x: 0, y: topHeight, width:view.frame.width, height: 40)
        return SearchBar
    }()
    
    /// 結果表示用テーブル
    lazy var Tbl: UITableView = {
        var Table = UITableView()
        Table.delegate = self
        Table.dataSource = self
        Table.dequeueReusableCell(withIdentifier: "Cells")
        Table.frame = CGRect(x: 0, y: SchBr.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - SchBr.frame.maxY)
        return Table
    }()
    
//    読み込み中に表示するインジケータ
    lazy var Loading: UIView = {
        let loadingView = UIView()
        loadingView.frame = CGRect(x: view.frame.width / 2 - 50, y: view.frame.height / 2 - 50, width: 100, height: 100)
        loadingView.backgroundColor = UIColor.gray
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.color = UIColor.white
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        return loadingView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//         画面回転を検知
        NotificationCenter.default.addObserver(self, selector:#selector(didChangeOrientation(_:)), name: UIDevice.orientationDidChangeNotification,object: nil)

//        ナビゲーションバー
        title = "Root View Controller"
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        
        
        self.view.backgroundColor = UIColor.systemBackground

        self.view.addSubview(SchBr)
        self.view.addSubview(Tbl)
        self.view.addSubview(Loading)
        Loading.isHidden = true
    }
    
    /// 画面回転検出時に実行
    @objc private func didChangeOrientation(_ notification: Notification) {
        SchBr.frame = CGRect(x: 0, y: topHeight, width:view.frame.width, height: 40)
        SchBr.setNeedsDisplay()
        Tbl.frame = CGRect(x: 0, y: SchBr.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - SchBr.frame.maxY)
        Tbl.setNeedsDisplay()
        Tbl.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        キーボードをしまう
        searchBar.resignFirstResponder()
        
        Loading.isHidden = false
        
        word = searchBar.text!
        print("wait...")
        
        if word.count != 0 {
            RepoData().getRepoDatas(searchWord: word) { data in
                self.repo = data
                DispatchQueue.main.async {
                    print("comp!")
                    self.Tbl.reloadData()
                    self.Loading.isHidden = true
                }
            }
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells") ??
                        UITableViewCell(style: .value1, reuseIdentifier: "Cells")
        let rp = repo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        tableView.deselectRow(at: indexPath, animated: true)

        let infoView = RepoInfoView()
//        ↓該当リポジトリのデータは全て渡しているので、後々表示項目を足しても大丈夫
        infoView.repoData = repo[indexPath.row]
        navigationController?.pushViewController(infoView, animated: true)
    }
    
}

extension UIViewController {
    
//    画面領域の使えるところの上端
    var topHeight:CGFloat {
//        ステータスバーの高さ＋ナビゲーションバーの高さ
        
        return (navigationController?.view.safeAreaInsets.top ?? 0.0) +
        (navigationController?.navigationBar.frame.size.height ?? 0.0)
    }
}
