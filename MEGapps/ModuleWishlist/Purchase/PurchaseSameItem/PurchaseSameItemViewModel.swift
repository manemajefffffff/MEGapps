//
//  PurchaseSameItemViewModel.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 10/11/21.
//

import Foundation
import Combine

class PurchaseSameItemViewModel: NSObject {
    
    @Published var items = [Items]()
    
    private lazy var purchaseSameItemCDM: PurchaseSameItemCoreDataManager = {return PurchaseSameItemCoreDataManager()}()
    
    override init() {
        super.init()
        fetchData()
    }
    
//MARK: - Functions
    func fetchData() {
        PurchaseSameItemCoreDataManager.shared.getAll {
            items in self.items = items
        }
    }
}
