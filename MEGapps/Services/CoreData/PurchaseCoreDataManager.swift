//
//  PurchaseCoreDataManager.swift
//  MEGapps
//
//  Created by Arya Ilham on 15/11/21.
//

import Foundation
import CoreData

class PurchaseCoreDataManager {
    static let shared = PurchaseCoreDataManager()
    
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

    func buyItem(itemWantToBuy: Items, hobbyBudgetUsed: Int64, budgetUsed: [BudgetUsed]) {
        let context = persistentContainer.viewContext
        
        // ubah status item jadi completed
        itemWantToBuy.status = "completed"
        do {
            try context.save()
        } catch {
            fatalError()
        }
        
        // catat pemakaian budget
        for budgetUse in budgetUsed {
            // buat object baru untuk catat pemakaian
            let otherBudgetUsage = TrItemBudget(context: context)
            otherBudgetUsage.items = itemWantToBuy
            otherBudgetUsage.budget = budgetUse.budget
            otherBudgetUsage.amount = budgetUse.amountUsed
            otherBudgetUsage.createdAt = Date()
            otherBudgetUsage.id = UUID()
            
            // ubah jumlah budget berdasarkan jumlah pemakaian
            if let budgetSource = budgetUse.budget {
                budgetSource.amount -= budgetUse.amountUsed
            }
            
            do {
                try context.save()
            } catch {
                fatalError()
            }
        }
        
        // tambahkan data budget terpakai
        let newSavingHistory = SavingsHistory(context: context)
        newSavingHistory.id = UUID()
        newSavingHistory.amount = hobbyBudgetUsed * -1
        newSavingHistory.createdAt = Date()
        newSavingHistory.wordings = "bought \(itemWantToBuy.name ?? "item") at price \(itemWantToBuy.price)"
        
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    // MARK: - Dead Code
    func createNewPurchase () {
        let context = persistentContainer.viewContext
        
        let newData = Items(context: context)
        
        do {
            try context.save()
        } catch {
            fatalError()
        }
        
    }
}
