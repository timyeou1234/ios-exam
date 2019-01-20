//
//  RandomContactServiceTest.swift
//  iOS_ExamTests
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import XCTest
import Alamofire
import Mockingjay
@testable import iOS_Exam

class RandomContactServiceTest: XCTestCase {

    var randomContactService :RandomContactServiceProtocol!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        randomContactService = RandomContactService()
        
        let url = Bundle(for: type(of: self)).url(forResource: "UserJson", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        stub(uri("api/TestSuccess"), jsonData(data))
        
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        randomContactService = nil
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToRandomUserServiceGetsHTTPStatusCode200() {
        // given
        let url = URL(string: RandomUserUrl)
        let promise = expectation(description: "Status code: 200")
        
        // when
        Alamofire.request(url!).responseJSON {
            (response) in
            if let error = response.error{
                ///獲取失敗，網路錯誤
                XCTFail("Error: \(error.localizedDescription)")
            }
            if let statusCode = response.response?.statusCode{
                if statusCode == 200 {
                    promise.fulfill()
                }else{
                    XCTFail("statusCode: \(statusCode)")
                }
            }
        }
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNormalRespones() {
        // given
        let url = URL(string: "api/TestSuccess")
        let promise = expectation(description: "Data Proccess Success")
        
        // when
        Alamofire.request(url!).responseJSON {
            (response) in
            if let error = response.error{
                ///獲取失敗，網路錯誤
                XCTFail("Error: \(error.localizedDescription)")
            }
            if let statusCode = response.response?.statusCode{
                if statusCode == 200 {
                    if ((RandomContactService().decodeJsonData(response))?.count)! > 0{
                        promise.fulfill()
                    }else{
                        XCTFail("資料解析錯誤")
                    }
                }else{
                    XCTFail("statusCode: \(statusCode)")
                }
            }
        }
        
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
}
