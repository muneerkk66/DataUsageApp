//
//  CoreDataManager.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

internal typealias completionBlock = (_ errorObject : NSError?) -> Void

class CoreDataManager: NSObject {
    
    static let sharedDataManager = CoreDataManager()
    
    override init() {
        
    }
    
    lazy var backgroundMasterContext : NSManagedObjectContext? = { [unowned self] in
        if let coordinator = self.persistentStoreCoordinator {
            var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
        }
        return nil
    }()
    
    lazy var mainContext : NSManagedObjectContext! = { [unowned self] in
        if let coordinator = self.persistentStoreCoordinator {
            var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.parent = self.backgroundMasterContext
            return context
        }
        return nil
    }()
    
    
    func createWriteContext() -> NSManagedObjectContext!  {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        if let coordinator = persistentStoreCoordinator {
            if let parentContext = mainContext {
                context.parent = parentContext
            }
            else if let parentContext = backgroundMasterContext {
                context.parent = parentContext
            }
            else {
                context.persistentStoreCoordinator = coordinator
            }
            return context
        }
        return nil
    }
    
    lazy var managedObjectModel : NSManagedObjectModel! = { [unowned self] in
        if let modelUrl = self.modelUrl {
            return NSManagedObjectModel(contentsOf: modelUrl)
        }
        return nil
    }()
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator! = { [unowned self] in
        
        
        
        if let model = self.managedObjectModel {
            var persistentCord : NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            let migrationOptions = [NSMigratePersistentStoresAutomaticallyOption: false,
                            NSInferMappingModelAutomaticallyOption: false]
            var error : NSError?
            do {
                try persistentCord.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeUrl, options: migrationOptions)
                
            }catch let error as NSError {
                abort()
            }
            return persistentCord
        }
        
        return nil
    }()
    
    
    func save(_ completion:@escaping completionBlock){
        
        let context:NSManagedObjectContext = self.mainContext;
        
        if (context.hasChanges) {
            
            do{
                
                try context.save()
                
                if let parentContext = context.parent {
                    parentContext.perform({ [weak self] () -> Void in
                        self?.saveAllWithContext(parentContext, completion: completion)
                    })
                } else {
                    completion(nil)
                }
                
            }catch let error as NSError {
                completion(error)
            }
            
        }else {
            completion(nil)
        }
        
    }
    
    func clearCoreDataStore() {
        let entities = managedObjectModel.entities
        backgroundMasterContext?.performAndWait {
            for entity in entities {
                if let entityName = entity.name {
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest (entityName: entityName)
                    let deleteReqest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    do {
                        try self.backgroundMasterContext?.execute(deleteReqest)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func saveAllWithContext(_ writeContext:NSManagedObjectContext, completion:@escaping completionBlock){
        do {
            try writeContext.save()
            if let parentContext = writeContext.parent {
                parentContext.perform({ [weak self] () -> Void in
                    self?.saveAllWithContext(parentContext, completion: completion)
                })
            } else {
                completion(nil)
            }
            
        }catch  let error as NSError {
            completion(error)
        }
    }
    
    var storeUrl : URL! {
        get {
            let documentsDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last! as URL
            return documentsDir.appendingPathComponent("MobileDataUsageApp.sqlite")
        }
    }
    
    var modelUrl : URL! {
        get {
            return Bundle.main.url(forResource: "MobileDataUsageApp", withExtension: "momd")
        }
    }
}
