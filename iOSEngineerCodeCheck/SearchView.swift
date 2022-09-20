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
    
    lazy var SchBr: UISearchBar = {
        let SearchBar = UISearchBar()
        SearchBar.text = "GitHubのリポジトリを検索できるよー"
        SearchBar.delegate = self
        SearchBar.frame = CGRect(x: 0, y: topHeight, width:view.frame.width, height: 40)
        return SearchBar
    }()
    
    lazy var Tbl: UITableView = {
        var Table = UITableView()
        Table.delegate = self
        Table.dataSource = self
        Table.dequeueReusableCell(withIdentifier: "Cells")
        Table.frame = CGRect(x: 0, y: SchBr.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - SchBr.frame.maxY)
        return Table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画面回転を検知
        NotificationCenter.default.addObserver(self, selector:#selector(didChangeOrientation(_:)), name: UIDevice.orientationDidChangeNotification,object: nil)

//        ナビゲーションバー
        title = "Root View Controller"
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        
        
        self.view.backgroundColor = UIColor.systemBackground

        self.view.addSubview(SchBr)
        self.view.addSubview(Tbl)
    }
    
    @objc private func didChangeOrientation(_ notification: Notification) {
        //画面回転時の処理
        
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
        
        word = searchBar.text!
        print("wait...")
        
        if word.count != 0 {
            RepoData().getRepoDatas(searchWord: word) { data in
                self.repo = data
                DispatchQueue.main.async {
                    print("comp!")
                    self.Tbl.reloadData()
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
