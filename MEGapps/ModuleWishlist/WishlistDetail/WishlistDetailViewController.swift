//
//  WishlistDetailViewController.swift
//  MEGapps
//
//  Created by Aldo Febrian on 27/10/21.
//

import UIKit
import Combine

class WishlistDetailViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel = WishlistDetailViewModel()
    // MARK: - container
    var container: Items?

    // MARK: - State
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Function
    override func loadView() {
        self.view = WishlistDetailView(viewModel: viewModel, viewController: self)
        viewModel.wishlist = container!
    }
    
    func showAcceptAlert() {
        let alert = UIAlertController(title: "Accept Wishlist", message: "Do you want to accept this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {(_)in
            print("User click Approve button")
            self.viewModel.acceptWishlist()
            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    func showDeleteAlert() {
        let alert = UIAlertController(title: "Cancel Wishlist", message: "Do you want to cancel this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: {(_)in
            print("User click Approve button")
            self.viewModel.cancelWishlist()
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func showEditPage() {
//        let storyboard = UIStoryboard(name: "WishlistAdd", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "wishlistAddSB")
//
//
//        self.present(vc, animated: true)
        
        let storyboard = UIStoryboard(name: "WishlistAdd", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "wishlistAddSB") as? WishlistAddView
        else {
            fatalError("VC not found")
        }
        viewController.oldWishlistData = viewModel.wishlist
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)

    }
}

extension WishlistDetailViewController: sendEditedWishlistBackDelegate {
    func send(_ editedItem: Items) {
        viewModel.wishlist = editedItem
    }
}
