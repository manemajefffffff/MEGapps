//
//  PurchaeOverviewViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 15/11/21.
//

import Foundation

class PurchaseOverviewViewModel: NSObject {
    
    @Published var purchaseOverview = Items()
    @Published var budgetUsed = [BudgetUsed]()
    
    override init() {
        
    }
    
    // MARK: - Function
    func accept() {
        
    }
    
    func cancel() {
        
    }
}