//
//  AppConstants.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let keyWindow = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.filter { $0.isKeyWindow }.first
class AppConstants: NSObject {
    // MARK: - URL & API details

    enum BaseURL: String {
        case production = "https://data.gov.sg"
        // case test                     = "http://data.gov.sg
    }

    // MARK: - Pointed Server

    static let baseURL = BaseURL.production.rawValue

    enum APIUrls: String {
        case dataUsage = "/api/action/datastore_search"
    }

    enum URLQUERY: String {
        case resource_id
    }

    static let resourceID = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    static let decimalLength = 4
    static let yearAndQuarterDivider = "-"

    // MARK: - Device Constants

    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenWidth = UIScreen.main.bounds.size.width

    // MARK: NibNames -

    enum NibNames: String {
        case datatUsageNib = "DataUsageTableViewCell"
    }

    // MARK: TableViewCellIdentifier -

    enum TableViewCellIdentifier: String {
        case datatUsageCellID = "DatatUsageCellID"
    }

    // MARK: StoryboardIdentifier -

    enum StoryboardIdentifier: String {
        case quarterVC = "quarterVCID"
        case dataUsageVC = "dataUsageVCID"
    }

    // MARK: Storyboard -

    enum StoryboardName: String {
        case main = "Main"
    }

    // MARK: Acce -

    enum AccessibilityIdentifier: String {
        case dataUsagetableView = "table--datausageTableView"
        case upArrowImage = "image--up"
        case downArrowImage = "image--down"
    }
}
