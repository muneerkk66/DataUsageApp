//
//  DataUsage+CoreDataProperties.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//
//

import CoreData
import Foundation

extension DataUsage {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataUsage> {
        return NSFetchRequest<DataUsage>(entityName: "DataUsage")
    }

    @NSManaged public var uniqueID: Int16
    @NSManaged public var mobileData: Double
    @NSManaged public var quarter: String?
}
