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
    
    // MARK: - Data Container
    var containerData: [Items] = []
    
    // MARK: - State
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
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
            .sink { items in
                self.containerData = items
                DispatchQueue.main.async {
                    self.wishlistTableView.reloadData()
                }
            }.store(in: &anyCancellable)
    }
    
    // MARK: - IBAction
    @IBAction func addNewWishlist(_ sender: Any) {
        // untuk dummy data
//        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {fatalError()}
//
//        let newData = Items(context: context)
//        newData.id = UUID()
//        newData.name = "gundam"
//        newData.createdAt = Date.now
//        newData.isPrioritize = false
//        newData.purchasedDate = nil
//        newData.deadline = Date.now.addingTimeInterval(864000)
//        newData.startSavingDate = nil
//        newData.price = 1000000
//        newData.reason = "i want to"
//        newData.category = "Collectibles"
//        newData.status = "waiting"
//        do {
//            try context.save()
//        } catch {
//            fatalError()
//        }
//        print("cek datanya: \(containerData[0].name)")
        
    }
}

// MARK: - TableView
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return containerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wishlistTableView.dequeueReusableCell(withIdentifier: "wishlistTableViewCell", for: indexPath) as? WishlistTableViewCell else {
            fatalError("no cell")
        }
        cell.newData = containerData[indexPath.row]
        return cell
    }
}
