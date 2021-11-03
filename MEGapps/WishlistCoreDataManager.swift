//
//  WishlistCoreDataManager.swift
//  MEGapps
//
//  Created by Arya Ilham on 03/11/21.
//

import Foundation
import CoreData

class WishlistCoreDataManager {
    static let shared = WishlistCoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MEGapps")

        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("\(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func get(completion: @escaping(_ itemList: [Items]) -> Void) {
        let context = newTaskContext()
        
        context.perform {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
            do {
                let result = try context.fetch(Items.fetchRequest())
                completion(result)
            } catch {
                print("error when fetching data")
            }
        }
    }
}
