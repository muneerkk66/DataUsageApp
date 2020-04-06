//
//  BaseVM.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
class BaseVM: NSObject {
    // MARK: - Common completetionblock for VM classes

    internal typealias VMDataCompletionBlock = (_ responseObject: Any?, _ errorObject: NSError?) -> Void
    internal typealias VMCompletionBlock = (_ errorObject: Error?) -> Void
}
