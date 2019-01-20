//
//  ContactListViewModelTests.swift
//  iOS_ExamTests
//
//  Created by YeouTimothy on 2019/1/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import XCTest
@testable import iOS_Exam

class ContactListViewModelTests: XCTestCase {
    
    var viewModel: ContactListViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
         viewModel = ContactListViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    /// Test if enter empty array will cause un expected error
    func testInputNilProccessContactList(){
        viewModel.processContactList([ContactModel]())
        XCTAssert(viewModel.numberOfCells == 0)
    }

    
    
}
