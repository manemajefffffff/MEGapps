//
//  PurchaseDetailCoreDataManager .swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 22/11/21.
//

import Foundation
import CoreData

class PurchaseDetailCoreDataManager {
    static let shared = PurchaseDetailCoreDataManager()
    
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
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAll(completion: @escaping(_ items: [Items]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let data = try context.fetch(Items.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
    
    func acceptAccWishlist(_ items: Items) {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    func deleteAccWishlist(_ items: Items) {
        let context = persistentContainer.viewContext
        context.delete(items)
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}
