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
    
    func get(completion: @escaping(_ itemList: [ItemModel]) -> Void) {
        let context = newTaskContext()
        
        context.perform {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
            do {
                let result = try context.fetch(Items.fetchRequest())
                var itemList: [ItemModel] = []
                for result in result {
                    itemList.append(
                        ItemModel(
                            itemID: result.value(forKey: "id") as? UUID,
                            name: result.value(forKey: "name") as? String,
                            reason: result.value(forKey: "reason") as? String,
                            status: result.value(forKey: "reason") as? String,
                            category: result.value(forKey: "category") as? String,
                            price: result.value(forKey: "price") as? Int64,
                            deadline: result.value(forKey: "deadline") as? Date,
                            startSavingDate: result.value(forKey: "startSavingDate") as? Date,
                            purchaseDate: result.value(forKey: "purchaseDate") as? Date,
                            createdAt: result.value(forKey: "createdAt") as? Date,
                            isPrioritize: result.value(forKey: "isPrioritize") as? Bool
                                        
                        )
                    )
                }
                completion(itemList)
            }
            catch {
                print("error when fetching data")
            }
        }
    }
}
