//
//  TrItemBudgetModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation

struct TrItemBudgetModel {
    var transactionID: UUID
    var amount: Int64 = 0
    var createdAt: Date
    
    init(transactionID: UUID, amount: Int64, createdAt: Date) {
        self.transactionID = transactionID
        self.amount = amount
        self.createdAt = createdAt
    }
}
