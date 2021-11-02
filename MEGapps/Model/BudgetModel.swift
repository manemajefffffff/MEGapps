//
//  BudgetModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation

struct BudgetModel {
    var budgetID: UUID
    var name: String = ""
    var amount: Int64 = 0
    
    init(budgetID: UUID, name: String, amount: Int64) {
        self.budgetID = budgetID
        self.name = name
        self.amount = amount
    }
}
