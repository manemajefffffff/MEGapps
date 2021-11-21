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
    @Published var oldBudgetData = Budget()
    @Published var isEditing: Bool = false
    
    // MARK: - Function
    override init() {
        
    }
    
    func saveBudget(name: String, amount: Int64) {
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
//        if !isEditing {
//            // akan add data baru
//        } else {
//            // akan update data lama
//        }
    }
    
    func deleteBudget() {
        
    }
}
