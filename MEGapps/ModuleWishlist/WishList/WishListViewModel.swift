//
//  WishListViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import Foundation
import Combine

class WishListViewModel: NSObject {
    
    // MARK: - Variables
    @Published var items = [Items]()
    @Published var hasItem: Bool = false
    
    override init() {
        super.init()
        fetchData()
    }
    
    // MARK: - Function
    func fetchData() {
        WishlistCoreDataManager.shared.getAll { items in
            self.hasItem = items.count > 0 ? true : false
            if self.items != items {
                self.items = items
                print("data refreshed")
            }
        }
    }
}
