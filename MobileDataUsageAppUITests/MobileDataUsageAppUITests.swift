//
//  MobileDataUsageAppUITests.swift
//  MobileDataUsageAppUITests
//
//  Created by x218507 on 03/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import XCTest
class MobileDataUsageAppUITests: XCTestCase {
    enum AccessibilityIdentifier: String {
        case dataUsagetableView              = "table--datausageTableView"
        case upArrowImage                    = "image--up"
        case downArrowImage                  = "image--down"
    }
var app: XCUIApplication!
    static let timeOut = 20
    override func setUp() {
       continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK:- Test Table View Interaction
   func testTableInteraction() {
        app.launch()
    let articleTableView = app.tables[AccessibilityIdentifier.dataUsagetableView.rawValue]
        XCTAssertTrue(articleTableView.exists, "The DatauSage tableview exists")
     
        // Get an array of cells
        let tableCells = articleTableView.cells
     if tableCells.count > 0 {
         let count: Int = (tableCells.count - 1)
         
         let promise = expectation(description: "Wait for table cells")
      
         for index in stride(from: 0, to: count , by: 1) {
             let tableCell = tableCells.element(boundBy: index)
             XCTAssertTrue(tableCell.exists, "The \(index) cell is in place on the table")
            if tableCell.images[AccessibilityIdentifier.upArrowImage.rawValue].exists{
                tableCell.tap()
            } else {
                 tableCell.tap()
                 articleTableView.forceTapElement()

            }
             if index == (count - 1) {
                 promise.fulfill()
             }
         }
        waitForExpectations(timeout: TimeInterval(MobileDataUsageAppUITests.timeOut), handler: nil)
         XCTAssertTrue(true, "Finished validating the table cells")
      
     } else {
         XCTAssert(false, "Was not able to find any table cells")
     }
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
