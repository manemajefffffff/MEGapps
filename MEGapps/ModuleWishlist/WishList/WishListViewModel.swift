//
//  WishListViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import Foundation

class WishListViewModel: NSObject {
    
    private var dataFromCoreData: WishListModel? {
        didSet {
            self.bindWishListViewModeltoController()
        }
    }
    
    var bindWishListViewModeltoController: (() -> Void) = {}
    
    override init() {
        super.init()
    }
    
    private func fetchData() {
        
    }
}
