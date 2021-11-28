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
    
    lazy var persistentContainer = CoreDataContext.sharedCDC.persistentContainer
    
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
    
    func saveNewWishlist(_ newItem: WishlistAdd, completion: @escaping(_ message: String) -> Void) {
        let context = persistentContainer.viewContext
        
        let newData = Items(context: context)
        newData.id = UUID()
        newData.wishlistNotificationId = newItem.notificationId
        newData.name = newItem.name
        newData.category = newItem.category
        newData.reason = newItem.reason
        newData.createdAt = Date()
        newData.deadline = newData.getDeadline() //newItem.deadline
        newData.price = newItem.price
        newData.isPrioritize = false
        newData.status = "waiting"
        
        do {
            try context.save()
            completion("success")
        } catch {
            completion("failed")
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
