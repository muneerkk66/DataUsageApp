//
//  DataListVM.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
class DataUsageVM: BaseVM {
    var apiHandler: DataUsageAPIHandler = DataUsageAPIHandler()
    var dataHandler: DataUsageDataHandler = DataUsageDataHandler()
    var dataUsageList = [MobileDataUsage]()
    var selectedDataUsage: MobileDataUsage?

    func fetchDataUsage(_ onCompletion: @escaping VMCompletionBlock) {
        apiHandler.fetchDataUsage { [weak self] (responseObject, errorObject) -> Void in
            guard let weakSelf = self else {
                return
            }
            guard let response = responseObject as? Data else {
                DispatchQueue.main.async {
                    onCompletion(errorObject)
                }
                return
            }
            do {
                // We have used Codable & Decodable for json encoding & decoding
                let dataUsageResponse = try JSONDecoder().decode(DataUsageAPIResponse.self, from: response)
                weakSelf.dataHandler.saveDataUsageList(dataUsageResponse.result.records, completionBlock: { error in
                    DispatchQueue.main.async {
                        onCompletion(error)
                    }
                })

            } catch {
                onCompletion(error)
            }
        }
    }

    // MARK: - Method that returns list of saved Data Usage Objects

    func loadDataUsageList() -> [MobileDataUsage]? {
        return dataHandler.fetchYearlyBasedDataUsage()
    }
}
