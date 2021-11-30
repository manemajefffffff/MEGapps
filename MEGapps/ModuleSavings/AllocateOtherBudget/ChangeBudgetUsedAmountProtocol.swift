//
//  ChangeBudgetUsedAmountProtocol.swift
//  MEGapps
//
//  Created by Arya Ilham on 25/11/21.
//

import Foundation

protocol ChangeBudgetUsedAmountProtocol: AnyObject {
    func deleteBudgetUsed(index: Int)
    func changeAmountWillUsed(amount: Int64, index: Int)
}
