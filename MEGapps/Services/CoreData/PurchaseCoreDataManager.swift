//
//  PurchaseCoreDataManager.swift
//  MEGapps
//
//  Created by Arya Ilham on 15/11/21.
//

import Foundation
import CoreData

enum ErrorStatus {
    case success
    case failed
}

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

    func proceedWishlist(itemWantToBuy: Items,
                         savingsAmountUsed: Int64,
                         budgetUsed: [BudgetUsed],
                         completion: @escaping(_ errorMessage: ErrorStatus) -> Void) {
        // ubah status item jadi completed
        guard let itemWTBContext = itemWantToBuy.managedObjectContext else { return }
        itemWantToBuy.status = "completed"
        do {
            try itemWTBContext.save()
        } catch {
            completion(.failed)
            fatalError()
        }
        
        // catat pemakaian budget
        for budgetUse in budgetUsed {
            // bug di bagian sini
            // buat object baru untuk catat pemakaian
            let budgetUseContext = persistentContainer.viewContext
            let otherBudgetUsage = TrItemBudget(context: budgetUseContext)
//            otherBudgetUsage.items = itemWantToBuy
//            otherBudgetUsage.budget = budgetUse.budget
            otherBudgetUsage.amount = budgetUse.amountUsed
            otherBudgetUsage.createdAt = Date()
            otherBudgetUsage.id = UUID()
            do {
                try budgetUseContext.save()
            } catch {
                completion(.failed)
                fatalError()
            }
            
            // ubah jumlah budget berdasarkan jumlah pemakaian
            if let budgetSource = budgetUse.budget {
                guard let budgetSourceContext = budgetSource.managedObjectContext else { return }
                budgetSource.amount -= budgetUse.amountUsed
                do {
                    try budgetSourceContext.save()
                } catch {
                    completion(.failed)
                }
            }
            
        }
        
        // tambahkan data budget terpakai
        let savingHistoryContext = persistentContainer.viewContext
        let newSavingHistory = SavingsHistory(context: savingHistoryContext)
        newSavingHistory.id = UUID()
        newSavingHistory.amount = savingsAmountUsed * -1
        newSavingHistory.createdAt = Date()
        newSavingHistory.wordings = "Purchase \(itemWantToBuy.name ?? "Item")"
        
        do {
            try savingHistoryContext.save()
        } catch {
            completion(.failed)
            fatalError()
        }
        print("berhasil proceed wishlist")
        completion(.success)
    }
}
