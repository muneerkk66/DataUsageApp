//
//  BaseAPIHandler.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
class BaseAPIHandler: NSObject {
    // MARK: - Common completetionblock for API classes

    internal typealias ApiCompletionBlock = (_ responseObject: AnyObject?, _ errorObject: NSError?) -> Void
    internal var networkManager: NetworkManager = NetworkManager()
}
