//
//  DataUsageAPIHandler.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DataUsageDataHandler:BaseDataHandler {
    
    //MARK: - Fetch Data Usage from DB
    func loadAllDataUsageDetails() -> [DataUsage] {
        let moc = coreDataManager.mainContext
        let dataFetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest (entityName: "DataUsage")
        do {
            let fetchedDatatList = try moc?.fetch(dataFetch) as? [DataUsage]
            return fetchedDatatList ?? []
        }
        catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
    //MARK: - Fetch Yearly based Data from DB
    func fetchYearlyBasedDataUsage() -> [MobileDataUsage]? {
        let dataUsageList:[DataUsage] = loadAllDataUsageDetails()
        var mobileDataList = [MobileDataUsage]()
        let quarterValue = dataUsageList.map {
            $0.quarter?.components(separatedBy: AppConstants.yearAndQuarterDivider).first
        }
        for (index,year) in quarterValue.unique().enumerated() {
            let quaterlyDataUsage = dataUsageList.filter {
                $0.quarter?.components(separatedBy: AppConstants.yearAndQuarterDivider).first { $0.hasPrefix(year ?? "") } != nil
            }.sorted(by: { ($0.quarter ?? "") < ($1.quarter ?? "") })
            
            var dataModel = MobileDataUsage()
            dataModel.year = Int(year ?? "")
            let mobileData = quaterlyDataUsage.map{$0.mobileData}
            dataModel.mobileData = mobileData.reduce(0,+)
            dataModel.quarter = quaterlyDataUsage
            dataModel.hasDecremented = mobileData.count > 1 && !mobileData.isDescending() && !mobileData.isAscending()
            mobileDataList.append(dataModel)
            
            if (index+1 == quarterValue.unique().count) {
                return mobileDataList.sorted (by: { ($0.year ?? 0) > ($1.year ?? 0 ) })
            }
        }
        return nil
    }
    
    //MARK: - DB handling for Data Usage List
    func saveDataUsageList(_ response:[DataUsageResponse], completionBlock:@escaping DataHandlerCompletionBlock) {
        
        //MARK:- fetch saved Data usage List
        var dataUsage:DataUsage?
        let writeContext = coreDataManager.createWriteContext()
        
        //MARK:- Check if any Data Usage entry is being deleted
        checkForDeleteDataUsage(responseData: response)
        
        //MARK:- Update Data Usage List
        for (index, dataUsageRes) in response.enumerated() {
            dataUsage = nil
            //MARK:- check for Data Usage object else create new one
            dataUsage = dataUsageWith(dataUsageRes.uniqueID, context: nil)
            if dataUsage == nil {
                dataUsage = NSEntityDescription.insertNewObject(forEntityName: "DataUsage", into: writeContext!) as? DataUsage
             }

            // MARK:- This needs to update in future with NSManagedObjects & Codable.
            dataUsage?.uniqueID = Int16(dataUsageRes.uniqueID)
            dataUsage?.quarter =  dataUsageRes.quarter
            dataUsage?.mobileData = Double(dataUsageRes.mobileData) ?? 0.0
    
            coreDataManager.saveAllWithContext((dataUsage?.managedObjectContext)!) { (errorObject) -> Void in
                if index == response.count - 1{
                    completionBlock(errorObject)
                }
            }
        }
    }
    //MARK:- check for the deleted Data usage details
    fileprivate func checkForDeleteDataUsage( responseData : [DataUsageResponse]) {
        let dataUsageObjects:[DataUsage] = loadAllDataUsageDetails()
        for dataObj in dataUsageObjects {
            if responseData.contains(where: { $0.uniqueID == dataObj.uniqueID }) == false{
               dataObj.managedObjectContext?.delete(dataObj)
            }
        }
    }
    
    //MARK:- Fetch Data usage Object with Data usage ID
    fileprivate func dataUsageWith(_ dataUsageID:Int, context:NSManagedObjectContext?) -> DataUsage? {
        let moc = context ?? coreDataManager.mainContext
        let dataFetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest (entityName: "DataUsage")
        dataFetch.predicate = NSPredicate(format:"uniqueID == %i",dataUsageID)
        do {
            let fetchedDataList = try moc?.fetch(dataFetch) as? [DataUsage]
            if fetchedDataList?.count ?? 0 > 0 {
                return fetchedDataList?.first
            }else {
                return nil
            }
        }
        catch {
            fatalError("Failed to fetch: \(error)")
        }
    }
    
}
