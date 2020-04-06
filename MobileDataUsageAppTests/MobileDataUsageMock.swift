//
//  DataUsageMockResponse.swift
//  MobileDataUsageAppTests
//
//  Created by x218507 on 05/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit
@testable import MobileDataUsageApp

class MockDataProvider: NSObject {
   let mobileData = MobileDataUsage(year: 2010, mobileData: 10.12345, quarter: nil, hasDecremented: true)
   var mockAPIResponse : DataUsageAPIResponse?
    
  func loadMockAPIResponse(){
        if let path = Bundle(for: type(of: self)).path(forResource: "MockAPIResponse", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let dataUsageResponse = try JSONDecoder().decode(DataUsageAPIResponse.self, from: data)
                  mockAPIResponse = dataUsageResponse
              } catch {
                   // handle error
              }
        }
    }
}
