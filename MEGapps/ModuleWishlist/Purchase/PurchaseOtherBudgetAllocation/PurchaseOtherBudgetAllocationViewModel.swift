//
//  PurchaseOtherBudgetAllocationViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 29/10/21.
//

import Foundation
import Combine

class PurchaseOtherBudgetAllocationViewModel: NSObject {
    
    // MARK: - Publishers
    @Published var budgetAmountUsed: Int64 = 0
    @Published var budgetUsage = [BudgetUsed]()
    @Published var isBudgetAllocatedEnough = false

    // MARK: - Variables
    var insufficientAmount: Int64 = 0
    
    override init() {
        super.init()
        self.getBudget()
        self.getBudgetAmountUsed()
    }
    
    // MARK: - Function(Other budget allocation)
    func getBudgetAmountUsed() {
        var amountUsedTemp: Int64 = 0
        for item in budgetUsage {
            amountUsedTemp += item.amountUsed
        }
        budgetAmountUsed = amountUsedTemp
    }
    
    func getBudget() {
        OtherBudgetCoreDataManager.shared.get { budgets in
            var allBudgetTemp: [BudgetUsed] = []
            for item in budgets {
                var allBudget = BudgetUsed()
                allBudget.budget = item
                allBudgetTemp.append(allBudget)
            }
            if allBudgetTemp.count > 0 {
                self.budgetUsage = allBudgetTemp
            }
        }
    }
    
    func setOtherBudgetUsageAmount(amountUsed: Int64, index: Int) {
        budgetUsage[index].amountUsed = amountUsed
    }
    
    func proceedWishlist() {
        
    }
}

extension PurchaseOtherBudgetAllocationViewModel {
    // MARK: - Function (Use budgets page)
    func addNewBudgetUse() {
        
    }
}
