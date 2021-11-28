//
//  PurchaseCoreDataManager.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 10/11/21.
//

import Foundation
import CoreData

class PurchaseSameItemCoreDataManager {
    static let shared = PurchaseSameItemCoreDataManager()
    
    lazy var persistentContainer = CoreDataContext.sharedCDC.persistentContainer
    
    func getAll(completion: @escaping(_ items: [Items]) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let data = try context.fetch(Items.fetchRequest())
            completion(data)
        } catch {
            fatalError()
        }
    }
}
