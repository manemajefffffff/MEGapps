//
//  PurchaeOverviewViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 15/11/21.
//

import Foundation

class PurchaseOverviewViewModel: NSObject {
    
    @Published var itemWantToBuy = Items()
    @Published var hobbyBudgetUsed = 0
    @Published var budgetUsed = [BudgetUsed]()
    
    override init() {
        
    }
    
    // MARK: - Function
    func accept() {
        
    }
}
