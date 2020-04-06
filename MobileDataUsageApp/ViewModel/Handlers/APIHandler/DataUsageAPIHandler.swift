//
//  DataUsageDataHandler.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
class DataUsageAPIHandler: BaseAPIHandler {
    func fetchDataUsage(_ onCompletion: @escaping ApiCompletionBlock) {
        guard var components = URLComponents(string: networkManager.baseURL + AppConstants.APIUrls.dataUsage.rawValue) else {
            return
        }
        let queryItem = URLQueryItem(name: AppConstants.URLQUERY.resource_id.rawValue, value: AppConstants.resourceID)
        components.queryItems = [queryItem]
        guard let urlpath = components.string else {
            return
        }
        networkManager.getRequestPath(url: urlpath, parameters: nil) { (responseObject, errorObject) -> Void in
            onCompletion(responseObject, errorObject)
        }
    }
}
