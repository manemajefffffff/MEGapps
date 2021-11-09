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
        let alert = UIAlertController(title: "Accept", message: "Please Select an Option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_)in
            print("User click Approve button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    func showDeleteAlert() {
        let alert = UIAlertController(title: "Delete", message: "Please Select an Option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {(_)in
            print("User click Approve button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

}
