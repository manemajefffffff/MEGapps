//
//  AllocateOtherBudgetsViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 25/11/21.
//

import Foundation
import Combine

protocol UseBudgetsFunctionProtocol {
    func addNewBudgetUse(index: Int)
    func setBudgetIsUsedStatus(index: Int)
}

class AllocateOtherBudgetViewModel: NSObject {
    
    // MARK: - Publishers
    @Published var budgetAmountUsed: Int64 = 0
    @Published var budgetUsed = [BudgetUsed]()
    @Published var budgetNotUsed = [BudgetUsed]()
    @Published var isBudgetAllocatedEnough = false

    // MARK: - Variables
    var insufficientAmount: Int64 = 0
    var item: Items?
    
    override init() {
        super.init()
        self.getBudget()
    }
    
    // MARK: - Function(Other budget allocation)
    private func checkBudgetAmountUsed() {
//        var amountUsedTemp: Int64 = 0
//        for item in budgetUsage {
//            amountUsedTemp += item.amountUsed
//        }
//        budgetAmountUsed = amountUsedTemp
        
        var amountUsedTemp: Int64 = 0
        for item in budgetUsed {
            amountUsedTemp += item.amountUsed
        }
        budgetAmountUsed = amountUsedTemp
        checkIfBudgetAllocationEnough()
    }
    
    func getBudget() {
//        OtherBudgetCoreDataManager.shared.get { budgets in
//            var allBudgetTemp: [BudgetUsed] = []
//            for item in budgets {
//                var allBudget = BudgetUsed()
//                allBudget.budget = item
//                allBudgetTemp.append(allBudget)
//            }
//            if allBudgetTemp.count > 0 {
//                self.budgetUsage = allBudgetTemp
//            }
//        }
        
        OtherBudgetCoreDataManager.shared.get { budgets in
            var notUsedBudgetListTemp: [BudgetUsed] = []
            for budget in budgets {
                var notUsedBudgetTemp = BudgetUsed()
                notUsedBudgetTemp.budget = budget
                notUsedBudgetListTemp.append(notUsedBudgetTemp)
            }
            if notUsedBudgetListTemp.count > 0 {
                self.budgetNotUsed = notUsedBudgetListTemp
            }
        }
    }
    
    func deleteUsedBudget(index: Int) {
        var budgetToNotUse = budgetUsed[index]
        budgetUsed.remove(at: index)
        budgetUsed = budgetUsed // nanti coba comment ini
        budgetToNotUse.amountUsed = 0
        budgetToNotUse.isUsed = false
        budgetNotUsed.append(budgetToNotUse)
        checkBudgetAmountUsed()
    }
    
    func setOtherBudgetUsageAmount(amountUsed: Int64, index: Int) {
        budgetUsed[index].amountUsed = amountUsed
        print(budgetUsed[index].amountUsed)
        checkBudgetAmountUsed()
    }
    
    private func checkIfBudgetAllocationEnough() {
        isBudgetAllocatedEnough = insufficientAmount == budgetAmountUsed ? true : false
    }
    
    private func removeUnusedBudget() {
        budgetUsed.removeAll { item in
            item.amountUsed <= 0
        }
    }
    
    private func getSavingsAmountUsed() -> Int64 {
        // masukin code untuk hitung tabungan yang terpakai
        return 100000
    }
    
    func proceedWishlist() {
        // save ke coredata
        removeUnusedBudget()
        PurchaseCoreDataManager
            .shared
            .proceedWishlist(itemWantToBuy: item!, savingsAmountUsed: getSavingsAmountUsed(), budgetUsed: budgetUsed) { errorMessage in
                switch errorMessage {
                case .success:
                    print("berhasil proses wishlist")
                case .failed:
                    print("gagal proses wishlist")
                }
            }

    }
}

extension AllocateOtherBudgetViewModel: UseBudgetsFunctionProtocol {
    // MARK: - Function (Use budgets page)
    func addNewBudgetUse(index: Int) {
        var budgetToUse = budgetNotUsed[index]
        budgetNotUsed.remove(at: index)
        budgetNotUsed = budgetNotUsed // nanti coba comment ini
        budgetToUse.isUsed = true
        budgetUsed.append(budgetToUse)
    }
    
    func setBudgetIsUsedStatus(index: Int) {
        budgetNotUsed[index].isUsed = !budgetNotUsed[index].isUsed
    }
}
