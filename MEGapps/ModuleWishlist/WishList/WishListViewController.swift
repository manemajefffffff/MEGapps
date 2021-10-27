//
//  WishListViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 27/10/21.
//

import UIKit

class WishListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var wishlistTableView: UITableView!
    // MARK: - ViewModel
    private let wishListViewModel = WishListViewModel()
    // MARK: - State
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerNib()
    }
    // MARK: - Function
    func registerNib() {
        wishlistTableView.register(UINib.init(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "wishlistTableViewCell")
    }
    // MARK: - IBAction
    @IBAction func addNewWishlist(_ sender: Any) {
    }
}
// MARK: - TableView
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wishlistTableView.dequeueReusableCell(withIdentifier: "wishlistTableViewCell", for: indexPath) as? WishlistTableViewCell else {
            fatalError("no cell")
        }
        return cell
    }
}
