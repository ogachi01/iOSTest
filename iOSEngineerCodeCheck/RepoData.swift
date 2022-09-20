//
//  RepoData.swift
//  iOSEngineerCodeCheck
//
//  Created by 小川拓也 on 2022/09/20.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

/// リポジトリデータを扱う関数群
class RepoData {
    
    
    /// 検索ワードからURLを生成し、リポジトリを検索
    /// - Parameter word: 検索ワード
    func getRepoDatas(searchWord: String, completion: @escaping ([[String:Any]]) -> Void) {
        var repos:[[String:Any]] = []
        let word = searchWord.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let url = "https://api.github.com/search/repositories?q=\(word!)"
        let requestUrl = URL(string: url)
        let task = URLSession.shared.dataTask(with: requestUrl!) { (data, res, err) in
            if (err != nil) {
                print("データ取得時エラー", err as Any)
            } else {
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        completion(items)
                        //                        DispatchQueue.main.async {
                        //                            self.Tbl.reloadData()
                        //                        }
                    }
                }
            }
        }
        task.resume()
    }
}
