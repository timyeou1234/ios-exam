//
//  RandomContactServiceTest.swift
//  iOS_ExamTests
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import XCTest
import Alamofire
@testable import iOS_Exam

class RandomContactServiceTest: XCTestCase {

    var randomContactService :RandomContactServiceProtocol!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        randomContactService = RandomContactService()
    }

    override func tearDown() {
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
