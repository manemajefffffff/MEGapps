//
//  SavingsViewModel.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 10/11/21.
//

import Foundation
import Combine

class SavingsViewModel: NSObject {
    
    @Published var savingsHistory = [SavingsHistory]()
        
    private lazy var savingsCDM: SavingsCoreDataManager = {return SavingsCoreDataManager() }()
    
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
}
