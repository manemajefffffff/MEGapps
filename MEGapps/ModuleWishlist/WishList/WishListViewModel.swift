//
//  WishListViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import Foundation
import Combine

class WishListViewModel: NSObject {
    
    @Published var items = [Items]()
//    var items = CurrentValueSubject<[Items], Never>([])
        
    private lazy var wishlistCDM: WishlistCoreDataManager = {return WishlistCoreDataManager() }()
    
    override init() {
        super.init()
        fetchData()
        print("data fetched")
    }
    // MARK: - Function
    func fetchData() {
        WishlistCoreDataManager.shared.getAll { items in
            self.items = items
        }
    }
}
