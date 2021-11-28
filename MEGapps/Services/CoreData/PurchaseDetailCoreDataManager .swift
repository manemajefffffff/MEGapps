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
            fetchRequest.predicate = NSPredicate(format: "isPrioritize == %@", true)
            let data = try context.fetch(Items.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
    
    func acceptAccWishlist(_ items: Items) {
        guard let objectContext = items.managedObjectContext else { return }
        items.status = "completed"
        do {
            try objectContext.save()
        } catch {
            fatalError()
        }
        
        let context = persistentContainer.viewContext

        let newSavingsHistory = SavingsHistory(context: context)
        newSavingsHistory.id = UUID()
        newSavingsHistory.createdAt = Date()
        newSavingsHistory.amount = items.price * -1
        newSavingsHistory.status = "debit"
        newSavingsHistory.wordings = "Purchase \(items.name ?? "Item")"
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    func deleteAccWishlist(_ items: Items) {
        guard let objectContext = items.managedObjectContext else { return }
        objectContext.delete(items)
        do {
            try objectContext.save()
        } catch {
            fatalError()
        }
    }
    
    func changePrioritizeStatus(_ items: Items) {
        guard let objectContext = items.managedObjectContext else { return }
        items.isPrioritize = items.isPrioritize
        print("Prioritize item \(items.isPrioritize)")
        do {
            try objectContext.save()
        } catch {
            fatalError()
        }
    }
}
