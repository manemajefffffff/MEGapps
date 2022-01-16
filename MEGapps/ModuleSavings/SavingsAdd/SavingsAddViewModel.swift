//
//  SavingsAddViewModel.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 11/11/21.
//

import Foundation
import Combine

enum SaveStatus {
    case noAmount
    case deductMoreThanCurrent
    case eligible
}

class SavingsAddViewModel: NSObject {
    
    var savingsHistory: [SavingsHistory] = []
    var newAmount: Int64 = 0
    var createdDate: Date = Date()
    var isAdd: Bool = true
    var currentSavingsAmount: Int64 = 0
    
    override init() {
        super.init()
//        fetchData()
        print("data fetched")
    }
    // MARK: - Function
    func fetchData() {
        SavingsAddCoreDataManager.shared.getAll { savingsHistory in
            self.savingsHistory = savingsHistory
        }
    }
    
    func saveSavingsAmount(createdDate: Date, amount: Int64) {
        isAdd == true ?
        SavingsAddCoreDataManager.shared.saveSavingsAmount(createdDate, abs(amount)) :
        SavingsAddCoreDataManager.shared.saveDeduct(createdDate, abs(amount))
    }
    
    func checkAmountField() -> SaveStatus {
        if newAmount == 0 { // case: tidak ada uang yang diinput / sama dengan nol
            return .noAmount
        } else if !isAdd && newAmount > currentSavingsAmount { // case: uang yang deduct lebih dari yang dipunya
            return .deductMoreThanCurrent
        }
        return .eligible
    }
    
}
