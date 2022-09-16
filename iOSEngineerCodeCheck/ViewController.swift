//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
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
        Table.frame = CGRect(x: 0, y: SchBr.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - SchBr.frame.maxY)
        return Table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        ナビゲーションバー
        title = "Root View Controller"
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        
        
        self.view.backgroundColor = UIColor.systemBackground

        self.view.addSubview(SchBr)
        self.view.addSubview(Tbl)
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
        
        word = searchBar.text!
        
        if word.count != 0 {
            word = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            url = "https://api.github.com/search/repositories?q=\(word!)"
            let requestUrl = URL(string: url)
            task = URLSession.shared.dataTask(with: requestUrl!) { (data, res, err) in
                if (err != nil) {
                    print("データ取得時エラー", err as Any)
                } else {
                    if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                        if let items = obj["items"] as? [[String: Any]] {
                            self.repo = items
                            DispatchQueue.main.async {
                                self.Tbl.reloadData()
                            }
                        }
                    }
                }
            }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "Detail"{
//            let dtl = segue.destination as! ViewController2
//            dtl.vc1 = self
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        let rp = repo[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        tableView.deselectRow(at: indexPath, animated: true)

        let vc2 = ViewController2()
        vc2.repoData = repo[indexPath.row]
        navigationController?.pushViewController(vc2, animated: true)
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
