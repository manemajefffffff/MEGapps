//
//  SavingsAddViewModel.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 11/11/21.
//

import Foundation
import Combine

class SavingsAddViewModel: NSObject {
    
    var savingsHistory: [SavingsHistory] = []
    var newAmount = 0
    
    override init() {
        super.init()
        fetchData()
        print("data fetched")
    }
    // MARK: - Function
    func fetchData() {
        SavingsAddCoreDataManager.shared.getAll { savingsHistory in
            self.savingsHistory = savingsHistory
        }
    }
    
    func saveSavingsAmount() {
        SavingsAddCoreDataManager.shared.saveSavingsAmount(savingsHistory)
    }
}
