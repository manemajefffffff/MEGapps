//
//  SavingsCoreDataManager.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 10/11/21.
//

import Foundation
import CoreData

class SavingsCoreDataManager {
    static let shared = SavingsCoreDataManager()
    
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
    
    func getAllItems(completion: @escaping(_ items: [Items]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest = Items.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "status == %@", "on_progress")
            let data = try context.fetch(fetchRequest)
            completion(data)
        } catch {
            fatalError()
        }
    }
}
