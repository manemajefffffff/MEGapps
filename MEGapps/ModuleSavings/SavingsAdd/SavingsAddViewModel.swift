//
//  SavingsAddViewModel.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 11/11/21.
//

import Foundation
import Combine

class SavingsAddViewModel: NSObject {
    
    @Published var savingsHistory: [SavingsHistory] = []
        
    private lazy var savingsAddCDM: SavingsAddCoreDataManager = {return SavingsAddCoreDataManager() }()
    
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
}
