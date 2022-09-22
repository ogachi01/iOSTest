//
//  iOSEngineerCodeCheckTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class iOSEngineerCodeCheckTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// リポジトリデータ取得部のテスト
    /// 正しく取得できていれば、取得データ件数は１件以上
    /// ５秒以上かかっても不合格扱い
    func testGetRepoDatas() throws {
        let expectation = self.expectation(description: "test Getting Repository Datas")
        let repoData = RepoData()
        
        repoData.getRepoDatas(searchWord: "test") { data in
            let receivedData = data
            expectation.fulfill()
            XCTAssertTrue(receivedData.count > 0)
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

}
