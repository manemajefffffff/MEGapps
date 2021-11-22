//
//  PurchaseCoreDataManager.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 10/11/21.
//

import Foundation
import CoreData

class PurchaseSameItemCoreDataManager {
    static let shared = PurchaseSameItemCoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MEGapps")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    
    func getAll(completion: @escaping(_ items: [Items]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let data = try context.fetch(Items.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
}
