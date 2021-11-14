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
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: - ViewModel
    private let wishListViewModel = WishListViewModel()
    var anyCancellable = Set<AnyCancellable>()
        
    // MARK: - State
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribe()
        fetchData()
        print("view will appear")
    }
    
    // MARK: - Function
    private func registerNib() {
        wishlistTableView.register(UINib.init(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "wishlistTableViewCell")
    }
    
    private func fetchData() {
        wishListViewModel.fetchData()
    }

    private func subscribe() {
        wishListViewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.wishlistTableView.reloadData()
                }
            }.store(in: &anyCancellable)
        
        wishListViewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setupNoDataView()
            }.store(in: &anyCancellable)
    }
    
    private func setupNoDataView() {
        if wishListViewModel.hasItem {
            wishlistTableView.backgroundView = nil
        } else {
            wishlistTableView.backgroundView = noDataView
        }
    }
    
    // MARK: - IBAction
    @IBAction func addNewWishlist(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PurchaseAdd", bundle: nil)
        guard let storyboardWL = storyboard.instantiateViewController(withIdentifier: "purchaseAddSB") as? PurchaseAddView
        else {
            fatalError("VC not found")
        }
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(storyboardWL, animated: true)
        
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
            cell.newData = wishListViewModel.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wishlistTableView.deselectRow(at: indexPath, animated: true)
        let wishlistDetailVC = WishlistDetailViewController()
        wishlistDetailVC.container = wishListViewModel.items[indexPath.row]
        navigationController?.pushViewController(wishlistDetailVC, animated: true)
    }
}
