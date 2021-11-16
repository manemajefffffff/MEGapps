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
            let fetchRequest = Items.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "status == %@", "waiting")
            let data = try context.fetch(fetchRequest)
            completion(data)
        } catch {
            fatalError()
        }
    }
    
    func acceptWishlist(_ items: Items) {
        let context = persistentContainer.viewContext
        items.status = "on_progress"
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    func cancelWishlist(_ items: Items) {
        let context = persistentContainer.viewContext
        context.delete(items)
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}