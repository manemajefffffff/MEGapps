//
//  WishListViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import UIKit
import Combine

class WishListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var wishlistTableView: UITableView!
    
    // MARK: - ViewModel
    private let wishListViewModel = WishListViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - State
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        fetchData()
        subscribe()
    }
    
    // MARK: - Function
    private func registerNib() {
        wishlistTableView.register(UINib.init(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "wishlistTableViewCell")
    }
    
    func fetchData() {
        wishListViewModel.fetchData()
        
    }
    
    func subscribe() {
        wishListViewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { _ in
                DispatchQueue.main.async {
                    self.wishlistTableView.reloadData()
                }
            }
            .store(in: &anyCancellable)
    }
    
    // MARK: - IBAction
    @IBAction func addNewWishlist(_ sender: Any) {
        
    }
}

// MARK: - TableView
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wishlistTableView.dequeueReusableCell(withIdentifier: "wishlistTableViewCell", for: indexPath) as? WishlistTableViewCell else {
            fatalError("no cell")
        }
        cell.itemNameLbl.text = "\(self.wishListViewModel.items.count)"

//        wishListViewModel.$items
//                    .receive(on: DispatchQueue.main)
//                    .sink { items in
////                        cell.itemNameLbl.text = "\(items[indexPath.row].name!)"
//
//                        // iseng-iseng coba observer
//                        cell.itemNameLbl.text = "\(self.wishListViewModel.items.count)"
//                    }
//                    .store(in: &anyCancellable)
                
        return cell
    }
}
