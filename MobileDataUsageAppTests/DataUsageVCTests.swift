//
//  MobileDataUsageAppTests.swift
//  MobileDataUsageAppTests
//
//  Created by x218507 on 03/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import XCTest
import UIKit
import FittedSheets
@testable import MobileDataUsageApp

class DataUsageVCTests: XCTestCase {

    var controller : DataUsageVC!
    override func setUp() {
        
        controller  = UIStoryboard(name: AppConstants.StoryboardName.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: AppConstants.StoryboardIdentifier.dataUsageVC.rawValue) as? DataUsageVC
        
    }

    override func tearDown() {
        super.tearDown()
    }
    //MARK:- Test Table View Initialization
    func testControllerHasTableView() {
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.dataUsageLisTableView,
                               "DataUsageVC should have a tableview")
    }
    //MARK:- Test Table View Cell
    func testTableViewHasCells() {
        let _ = controller.view
        let cell = controller.dataUsageLisTableView.dequeueReusableCell(withIdentifier:AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue)

        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'AppConstants.TableViewCellIdentifier.datatUsageCellID.rawValue'")
    }
    
   //MARK:- Test Table View Behaviour after Data source is set
   func testDataProviderHasTableViewPropertySetAfterLoading() {
      let mockDataProvider = MockDataProvider()
      controller.dataUsageVM.dataUsageList = [mockDataProvider.mobileData]
      XCTAssertNil(controller.dataUsageLisTableView, "Before loading the table view should be nil")
      let _ = controller.view
      XCTAssertTrue(controller.dataUsageLisTableView != nil, "The table view should be set")
      XCTAssert(controller.dataUsageLisTableView === controller.dataUsageLisTableView, "The table view should be set to the table view of the data source")
    }
    
    //MARK:- Test Table View Cell row
    func testDataHasTableViewRowsEaqualToMobileDataList() {
      let mockDataProvider = MockDataProvider()
      controller.dataUsageVM.dataUsageList = [mockDataProvider.mobileData]
      let tableView = UITableView()

      let numberOfRows = controller.tableView(tableView, numberOfRowsInSection: 0)
      XCTAssertEqual(numberOfRows, 1,
                     "Number of rows in table should match number of dataUsageList")
    }
    
    //MARK:- Test Table View Cell Selection
    func testSelectingCellToSetSelectedMobileData() {
        let _ = controller.view
        let mockDataProvider = MockDataProvider()
        controller.dataUsageVM.dataUsageList = [mockDataProvider.mobileData]
        
        controller.tableView(controller.dataUsageLisTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(controller.dataUsageVM.selectedDataUsage != nil,"")
    }
    //MARK:- Test API calls & Network error handling
    func testMobileDataUsageAPICalls() {
        let expect = expectation(description: "API Calls")
        controller.dataUsageVM.apiHandler.fetchDataUsage { (responseObject, error) in
            XCTAssertNil(error, "API calls failed due to , error \(error!.localizedDescription)")
            XCTAssertNotNil(responseObject, "Mobile Data API calls succeeded")
            
             guard let response = responseObject as? Data else {
                 XCTFail("Mobile Data API calls failed")
                return
             }
             do {
                 let dataUsageResponse = try JSONDecoder().decode(DataUsageAPIResponse.self, from: response)
                 XCTAssertNotNil(dataUsageResponse, "API Response succeded with JSONDecoder")
                 
             } catch {
                XCTFail("Mobile Data API calls failed")
             }
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    //MARK:- Test Core data Fetching
    func testCoreDataFetching() {
        controller.dataUsageVM.dataUsageList = controller.dataUsageVM.loadDataUsageList() ?? []
        XCTAssertNotNil(controller.dataUsageVM.dataUsageList, "Core Data fetch succeeded")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
           testMobileDataUsageAPICalls()
        }
    }

}

