//
//  BaseDataHandler.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
class BaseDataHandler: NSObject {
    // MARK: - Common completetionblock for DataHandler classes

    internal typealias DataHandlerCompletionBlock = (_ errorObject: NSError?) -> Void
    var coreDataManager = CoreDataManager.sharedDataManager
}
