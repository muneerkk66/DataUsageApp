//
//  NetworkManagerTests.swift
//  MobileDataUsageAppTests
//
//  Created by x218507 on 08/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import XCTest
@testable import Alamofire
@testable import MobileDataUsageApp
class NetworkManagerTests: XCTestCase {
    private var managerSuit: NetworkManager!
    override func setUp() {
        let manager: SessionManager = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockURLProtocol.self]
                return configuration
            }()
            return SessionManager(configuration: configuration)
        }()
        managerSuit = NetworkManager(manager: manager)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadDataUsageSucceed() {
        MockURLProtocol.responseWithStatusCode(code: 200)
        let mockDataProvider = MockDataProvider()
        let expectation = XCTestExpectation(description: "Load API Performs a request")
        guard let urlPath = mockDataProvider.getURlpath() else {
             XCTFail("Network Failed for Status Code 200")
            return
        }
        managerSuit.getRequestPath(url: urlPath, parameters: nil) { (response, error) in
            guard let _ = response as? Data else {
                XCTFail("Network Failed for Status Code 200")
                return
            }
            expectation.fulfill()
         }
        wait(for: [expectation], timeout: 3)
    }
    
    func testMockResponse() {
        let mockDataProvider = MockDataProvider()
        mockDataProvider.loadMockAPIResponse()
        let mockResponse = mockDataProvider.mockAPIResponse
        let expectation = XCTestExpectation(description: "Mock Response")
        managerSuit.getRequestPath(url: mockDataProvider.getURlpath()!, parameters: nil) { (response, error) in
            guard let _ = response as? Data else {
                XCTFail("Network Failed")
                return
            }
            do {
                let dataUsageResponse = try JSONDecoder().decode(DataUsageAPIResponse.self, from: response as! Data)
                for (index, element) in dataUsageResponse.result.records.enumerated() {
                  XCTAssertEqual(element.mobileData, mockResponse?.result.records[index].mobileData,"Failed to compare mobile data from mock response")
                  XCTAssertEqual(element.quarter, mockResponse?.result.records[index].quarter,"Failed to compare quarter data from mock response")
                }
                expectation.fulfill()

            } catch {
                XCTFail()
            }
           
         }
        wait(for: [expectation], timeout: 3)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
