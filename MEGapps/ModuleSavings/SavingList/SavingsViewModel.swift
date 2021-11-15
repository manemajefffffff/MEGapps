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

    override init() {
        super.init()
        fetchData()
        print("data fetched")
    }
    // MARK: - Function
    func fetchData() {
        SavingsCoreDataManager.shared.getAll { savingsHistory in
            self.savingsHistory = savingsHistory
        }
    }
    
    func changeSavingsValue(value: Int) {
        total += value
    }
    
    func getValue() {
        
    }
}
