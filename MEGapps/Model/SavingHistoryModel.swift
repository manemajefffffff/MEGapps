//
//  SavingHistoryModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation

struct SavingHistoryModel {
    var savingHistoryID: UUID
    var amount: Int64 = 0
    var wordings: String = ""
    var createdAt: Date
    
    init(savingHistoryID: UUID, amount: Int64, wordings: String, createdAt: Date) {
        self.savingHistoryID = savingHistoryID
        self.amount = amount
        self.wordings = wordings
        self.createdAt = createdAt
    }
}
