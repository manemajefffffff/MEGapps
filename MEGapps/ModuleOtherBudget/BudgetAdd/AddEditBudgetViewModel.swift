//
//  AddEditBudgetViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 21/11/21.
//

import Foundation
import Combine

class AddEditBudgetViewModel: NSObject {
    
    // MARK: - Publishers
    var oldBudgetData: Budget? {
        didSet {
            isEditing = true
        }
    }
    
    @Published var isEditing: Bool?
    
    // MARK: - Function
    override init() {
        
    }
    
    func saveBudget(name: String, amount: Int64) {
        switch isEditing {
        case true:
            oldBudgetData?.name = name
            oldBudgetData?.amount = amount
            OtherBudgetCoreDataManager.shared.edit(editedBudget: oldBudgetData!) { message in
                switch message {
                case "success":
                    print("add new budget success")
                case "failed" :
                    print("add new budget failed")
                default:
                    break
                }
            }
        default:
            OtherBudgetCoreDataManager.shared.add(name, amount) { message in
                switch message {
                case "success":
                    print("add new budget success")
                case "failed" :
                    print("add new budget failed")
                default:
                    break
                }
            }
        }
    }
    
    func deleteBudget() {
        if let toDeleteData = oldBudgetData {
            OtherBudgetCoreDataManager.shared.delete(toDeleteData)

        }
    }
}
