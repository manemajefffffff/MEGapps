//
//  SavingsAddCoreDataManager.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 11/11/21.
//

import Foundation
import CoreData

class SavingsAddCoreDataManager {
    static let shared = SavingsAddCoreDataManager()
    
    lazy var persistentContainer = CoreDataContext.sharedCDC.persistentContainer
    
    func getAll(completion: @escaping(_ savingsHistory: [SavingsHistory]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let data = try context.fetch(SavingsHistory.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
    
    func saveSavingsAmount(_ createdDate: Date, _ amount: Int64) {
        let context = persistentContainer.viewContext

        let newSavingsHistory = SavingsHistory(context: context)
        newSavingsHistory.id = UUID()
        newSavingsHistory.createdAt = createdDate
        newSavingsHistory.amount = amount
        newSavingsHistory.status = "credit"
        newSavingsHistory.wordings = "Savings"
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}
