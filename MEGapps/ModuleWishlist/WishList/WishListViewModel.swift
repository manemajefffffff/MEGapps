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
    @Published var readyToAcceptItems = [Items]()
    @Published var hasReadyToAcceptItems: Bool = false
    
    override init() {
        super.init()
        fetchData()
    }
    
    // MARK: - Function
    func fetchData() {
        WishlistCoreDataManager.shared.getAll { items in
            self.items.removeAll()
            self.readyToAcceptItems.removeAll()
            for item in items where item.status == "waiting" {
                if item.deadline! > Date() {
                    self.items.append(item)
                } else {
                    self.readyToAcceptItems.append(item)
                }
            }
            self.hasItem = self.items.count > 0 ? true : false
            self.hasReadyToAcceptItems = self.readyToAcceptItems.count > 0 ? true : false
            print("data refreshed")
        }
    }
}
