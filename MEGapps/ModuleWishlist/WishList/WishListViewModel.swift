//
//  WishListViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import Foundation
import Combine

class WishListViewModel: ObservableObject {
    
    @Published var items = [Items]()
        
    private lazy var wishlistCDM: WishlistCoreDataManager = {return WishlistCoreDataManager() }()

    init() {}
    // MARK: - Function
    func fetchData() {
        // pastikan kalau kosong
        items.removeAll()
        self.wishlistCDM.get { itemList in
            self.items = itemList
        }
    }
}
