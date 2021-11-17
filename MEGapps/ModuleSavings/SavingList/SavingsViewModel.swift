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
    @Published var savingsHistory: [SavingsHistory] = []
    
    override init() {
        super.init()
        fetchData()
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
}
