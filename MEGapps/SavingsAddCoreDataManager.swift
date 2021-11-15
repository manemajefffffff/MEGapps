//
//  SavingsAddCoreDataManager.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 11/11/21.
//

import Foundation
import CoreData

class SavingsAddCoreDataManager {
    static let shared = SavingsAddCoreDataManager()
    
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
    
    func getAll(completion: @escaping(_ savingsHistory: [SavingsHistory]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let data = try context.fetch(SavingsHistory.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
    
    func saveSavingsAmount(_ savingsHistory: [SavingsHistory]) {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}
