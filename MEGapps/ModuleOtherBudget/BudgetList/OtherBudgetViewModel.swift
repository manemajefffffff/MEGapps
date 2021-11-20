//
//  OtherBudgetViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 20/11/21.
//

import Foundation
import Combine

class OtherBudgetViewModel: NSObject {
    
    // MARK: - Publisher
    @Published var otherBudget = [Budget]()
    @Published var hasItem: Bool = false

    override init() {
        super.init()
        self.fetchData()
    }
    
    private func fetchData() {
        OtherBudgetCoreDataManager.shared.get { budgets in
            if budgets.count > 0 {
                self.otherBudget = budgets
                self.hasItem = true
            } else {
                self.hasItem = false
            }
        }
    }
    
}
