//
//  BaseVCTests.swift
//  MobileDataUsageAppTests
//
//  Created by x218507 on 06/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import XCTest
import UIKit
@testable import MobileDataUsageApp
class BaseVCTests: XCTestCase {
var controller : BaseVC!
    override func setUp() {
       controller = BaseVC()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
     func testPresentAlertDialogue() {
        controller.showAlert("testPresentErrorDialogue")
       let expectation = XCTestExpectation(description: "testPresentErrorDialogue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(keyWindow?.rootViewController?.presentedViewController is UIAlertController)
         expectation.fulfill()
       })
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
