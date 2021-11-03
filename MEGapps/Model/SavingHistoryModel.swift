//
//  SavingHistoryModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation

struct SavingHistoryModel {
    var savingHistoryID: UUID?
    var amount: Int64? = 0
    var wordings: String? = ""
    var createdAt: Date?
}
