//
//  PurchaeOverviewViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 15/11/21.
//

import Foundation

class PurchaseOverviewViewModel {
    
    let bundle: Bundle
    
    @Published var itemWantToBuy: Items? {
        didSet {
            if let price = itemWantToBuy?.price {
                savingAmount = price
            }
        }
    }
    @Published var otherBudgetAmount: Int64 = 0
    @Published var savingAmount: Int64 = 0
    
    var budgetUsed: [BudgetUsed]? {
        didSet {
            calculateOtherBudgetAmount()
            calculateSavingAmount()
        }
    }
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    func calculateOtherBudgetAmount() {
        
        if let budgetCalculate = budgetUsed {
            var temp: Int64 = 0
            for object in budgetCalculate {
                temp += object.amountUsed
            }
            otherBudgetAmount =  temp
        }
    }
    
    func calculateSavingAmount() {
        if let price = itemWantToBuy?.price {
            savingAmount = price - otherBudgetAmount
        }
    }
}
