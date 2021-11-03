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
    
//    private var anyCancellable = Set<AnyCancellable>()
    
    private lazy var wishlistCDM: WishlistCoreDataManager = {return WishlistCoreDataManager() }()

    init() {}
    // MARK: - Function
    func fetchData() {
        // pastikan kalau kosong
        items.removeAll()
//        items.append(
//            ItemModel(
//                itemID: UUID(),
//                name: "test nama",
//                reason: "test alasan",
//                status: "test status",
//                category: "test kategori",
//                price: 100004,
//                deadline: Date(),
//                startSavingDate: Date(),
//                purchaseDate: Date(),
//                createdAt: Date(),
//                isPrioritize: false
//            )
//        )
        self.wishlistCDM.get { itemList in
            self.items = itemList
        }
        
    }
    
    func addNewData(){
        items.append(
                    ItemModel(
                        itemID: UUID(),
                        name: "test nama",
                        reason: "test alasan",
                        status: "test status",
                        category: "test kategori",
                        price: 100004,
                        deadline: Date(),
                        startSavingDate: Date(),
                        purchaseDate: Date(),
                        createdAt: Date(),
                        isPrioritize: false
                    )
                )
    }
}
