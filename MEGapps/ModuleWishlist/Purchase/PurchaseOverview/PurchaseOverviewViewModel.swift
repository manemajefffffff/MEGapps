//
//  PurchaeOverviewViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 15/11/21.
//

import Foundation

class PurchaseOverviewViewModel {
    
    let bundle: Bundle
    
    @Published var itemWantToBuy: Items?
    @Published var budgetUsed: [BudgetUsed]?
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
}
