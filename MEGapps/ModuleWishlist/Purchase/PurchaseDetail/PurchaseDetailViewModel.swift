//
//  PurchaseDetailViewModel.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import Combine

class PurchaseDetailViewModel {


    let bundle: Bundle
    @Published var accWishlistDetail = Items()
    @Published var item: Items?
    @Published var savingsTotal: Int64 = 0
    @Published var savingsLeft: Int64 = 0
    @Published var isSufficient = false

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
        fetchData()
        calculate()
    }
    
    // MARK: - Function
    
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
        if let item = item {
            self.savingsLeft = savingsTotal - item.price
            
            if savingsTotal < item.price {
                isSufficient = true
            } else if savingsTotal >= item.price {
                isSufficient = false
            }
        }
    }
    
    func acceptAccWishlist() {
        PurchaseDetailCoreDataManager.shared.acceptAccWishlist(accWishlistDetail)
    }
    
    func deleteAccWishlist() {
        PurchaseDetailCoreDataManager.shared.deleteAccWishlist(accWishlistDetail)
    }
}
