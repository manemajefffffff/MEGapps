//
//  OtherBudgetCoreDataManager.swift
//  MEGapps
//
//  Created by Arya Ilham on 20/11/21.
//

import Foundation
import CoreData

class OtherBudgetCoreDataManager {
    static let shared = OtherBudgetCoreDataManager()
    
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
    
    func get(completion: @escaping(_ budgets: [Budget]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest = Budget.fetchRequest()
            let data = try context.fetch(fetchRequest)
            completion(data)
        } catch {
            fatalError()
        }
    }
}
