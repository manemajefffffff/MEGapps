//
//  WishListViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import Foundation
import Combine

class WishListViewModel {
    
//    private var dataFromCoreData: WishListModel? {
//        didSet {
//            self.bindWishListViewModeltoController()
//        }
//    }
    
//    var bindWishListViewModeltoController: (() -> Void) = {}
    
    @Published var items = [ItemModel]()
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init() {}
    // MARK: - Function
    func fetchData() {
        // pastikan kalau kosong
        items.removeAll()
    }
}
