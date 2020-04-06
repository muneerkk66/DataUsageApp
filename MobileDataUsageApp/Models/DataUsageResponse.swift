//
//  DataUsageResponse.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
struct DataUsageResponse: Codable {
    var uniqueID: Int
    var mobileData: String
    var quarter: String

    // MARK: Codingkey Swift will automatically use this as the key type. This therefore allows you to easily customise the keys that your properties are encoded/decoded with.

    enum CodingKeys: String, CodingKey {
        case quarter
        case uniqueID = "_id"
        case mobileData = "volume_of_mobile_data"
    }
}

struct DataUsageAPIResponse: Codable {
    var result: Records
}

struct Records: Codable {
    var records: [DataUsageResponse]
}

struct MobileDataUsage {
    var year: Int?
    var mobileData: Double?
    var quarter: [DataUsage]?
    var hasDecremented: Bool = false
}
