//
//  SavingsHistoryViewModel.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 11/11/21.
//

import Foundation
import Combine

class SavingsHistoryViewModel: NSObject {
    @Published var savingHistory = [SavingsHistory]()
        
    private lazy var wishlistCDM: SavingHistoryCoreDataManager = {return SavingHistoryCoreDataManager() }()
    
    override init() {
        super.init()
        fetchData()
        print("data fetched")
    }
    // MARK: - Function
    func fetchData() {
        SavingHistoryCoreDataManager.shared.getAll { savingHistory in
            self.savingHistory = savingHistory
        }
        self.savingHistory = savingHistory.sorted(by: {
            $0.createdAt?.compare($1.createdAt ?? Date()) == .orderedDescending
        })
    }
    
}
