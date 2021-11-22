//
//  SavingsViewModel.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 10/11/21.
//

import Foundation
import Combine

class SavingsViewModel: NSObject {
    @Published var total = 0
    var savingsHistory: [SavingsHistory] = []
    @Published var items: [Items] = []
    
    override init() {
        super.init()
        fetchData()
        fetchDataItems()
    }
    
    // MARK: - Function
    func fetchData() {
        SavingsCoreDataManager.shared.getAll { savingsHistory in
            self.savingsHistory = savingsHistory
            var tempTotal = 0
            for savingHistory in savingsHistory {
                tempTotal+=Int(savingHistory.amount)
            }
            self.total = tempTotal
        }
    }
    
    func fetchDataItems() {
        SavingsCoreDataManager.shared.getAllItems { items in
            self.items = items
        }
    }
}
