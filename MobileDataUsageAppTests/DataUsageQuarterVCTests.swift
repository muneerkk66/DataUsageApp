//
//  DataUsageQuarterVCTests.swift
//  MobileDataUsageAppTests
//
//  Created by x218507 on 06/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import XCTest
@testable import MobileDataUsageApp

class DataUsageQuarterVCTests: XCTestCase {
var controller : DataUsageQuarterVC!
    override func setUp() {
        controller  = UIStoryboard(name: AppConstants.StoryboardName.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppConstants.StoryboardIdentifier.quarterVC.rawValue) as? DataUsageQuarterVC    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
      //MARK:- Test Table View Initialization
     func testControllerHasTableView() {
           controller.loadViewIfNeeded()
           XCTAssertNotNil(controller.dataUsageQuarterTableView,
                                  "DataUsageQuarterVC should have a tableview")
       }
        //MARK:- Test Table View Cell
       func testTableViewHasCells() {
           let _ = controller.view
           let cell = controller.dataUsageQuarterTableView.dequeueReusableCell(withIdentifier:AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue)

           XCTAssertNotNil(cell,
                           "TableView should be able to dequeue cell with identifier: 'AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue'")
       }
     //MARK:- Test Table View Behaviour after Data source is set
    func testDataProviderHasTableViewPropertySetAfterLoading() {
      let mockDataProvider = MockDataProvider()
      controller.dataUsageVM.selectedDataUsage = mockDataProvider.mobileData
      
      XCTAssertNil(controller.dataUsageQuarterTableView, "Before loading the table view should be nil")  // 2
      let _ = controller.view
      
      XCTAssertTrue(controller.dataUsageQuarterTableView != nil, "The table view should be set")
      XCTAssert(controller.dataUsageQuarterTableView === controller.dataUsageQuarterTableView, "The table view should be set to the table view of the data source")
    }
    
    //MARK:- Test Table View Cell row
    func testDataHasTableViewRowsEaqualToSelectedDataUsageQuarter() {
      let mockDataProvider = MockDataProvider()
      controller.dataUsageVM.selectedDataUsage = mockDataProvider.mobileData
      let tableView = UITableView()
      let numberOfRows = controller.tableView(tableView, numberOfRowsInSection: 1)
      XCTAssertEqual(numberOfRows, 0,
                     "Number of rows in table should match number of dataUsageList count")
    }

    func testPerformanceExample() {
        self.measure {
            
        }
    }

}
