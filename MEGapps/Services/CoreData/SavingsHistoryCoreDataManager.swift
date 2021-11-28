//
//  SavingsHistoryCoreDataManager.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 11/11/21.
//

import Foundation
import CoreData

class SavingHistoryCoreDataManager {
//    lazy var persistentContainer: NSPersistentContainer = {
//        let persistentContainer = NSPersistentContainer(name: "MEGapps")
//        persistentContainer.loadPersistentStores{ _, error in
//            print(error?.localizedDescription ?? "")
//        }
//        return persistentContainer
//    }()
//
//    var history: NSManagedObjectContext {
//        persistentContainer.viewContext
//    }
//
//    func getAll() {
//
//    }
//
//    func get() -> [SavingsHistory] {
//        do {
//            let fetchRequest = NSFetchRequest<SavingsHistory>(entityName: "SavingsHistory")
//            let savingHistory = try history.fetch(fetchRequest)
//            return savingHistory
//        } catch {
//            print(error)
//            return []
//        }
//    }
    
    static let shared = SavingHistoryCoreDataManager()
    
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
    
    func getAll(completion: @escaping(_ items: [SavingsHistory]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let data = try context.fetch(SavingsHistory.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
    
    
    
}
