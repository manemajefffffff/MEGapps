//
//  UseOtherBudgetViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 25/11/21.
//

import Foundation
import Combine

class UseOtherBudgetViewModel: NSObject {
    // MARK: Publisher
    var budgetUsed = [BudgetUsed]()
    @Published var budgetNotUsed = [BudgetUsed]()

    override init() {
        
    }
    
    func changeIsUsedStatus(index: Int) {
        budgetNotUsed[index].isUsed = !budgetNotUsed[index].isUsed
    }
    
    func saveChanges() {
        // pindahin budget yang akan terpakai ke budgetUsed
        for item in budgetNotUsed where item.isUsed {
            budgetUsed.append(item)
        }
        // hapus budget yang terpakai dari budgetNotUsed
        budgetNotUsed.removeAll { data in
            data.isUsed == true
        }
    }
}
