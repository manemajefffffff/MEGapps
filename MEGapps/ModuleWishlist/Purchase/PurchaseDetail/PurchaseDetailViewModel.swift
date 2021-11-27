//
//  PurchaseDetailViewModel.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import Combine
import UIKit

class PurchaseDetailViewModel {
    let bundle: Bundle
    @Published var item = Items()
    @Published var savingsTotal: Int64 = 0
    @Published var savingsLeft: Int64 = 0
    @Published var insufficientAmt: Int64 = 0
    @Published var isSufficient = false

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
        fetchData()
        print("Test Init")
    }
    
    func fetchData() {
        SavingsCoreDataManager.shared.getAll { savingsHistory in
            var tempTotal = 0
            for savingHistory in savingsHistory {
                tempTotal+=Int(savingHistory.amount)
            }
            self.savingsTotal = Int64(tempTotal)
        }
    }
        
    func calculate() {
            if savingsTotal >= item.price {
                isSufficient = true
                print("Sufficient True View Model")
                self.savingsLeft = savingsTotal - item.price
            } else if savingsTotal < item.price {
                isSufficient = false
                print("Sufficient False View Model")
                self.insufficientAmt = item.price - savingsTotal
            }
    }
    
    func changePriorityStatus() {
        item.isPrioritize = !item.isPrioritize
        PurchaseDetailCoreDataManager.shared.changePrioritizeStatus(item)
        
    }
    
    func acceptAccWishlist() {
        PurchaseDetailCoreDataManager.shared.acceptAccWishlist(item)
    }
    
    func deleteAccWishlist() {
        PurchaseDetailCoreDataManager.shared.deleteAccWishlist(item)
    }
}
