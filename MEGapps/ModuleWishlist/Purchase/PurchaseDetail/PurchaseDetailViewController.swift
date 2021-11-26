//
//  PurchaseDetailViewController.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import UIKit

class PurchaseDetailViewController: UIViewController {
    
    var viewModel = PurchaseDetailViewModel()
    var itemsPD: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func loadView() {
        self.view = PurchaseDetailView(viewModel: viewModel, viewController: self)
        viewModel.item = itemsPD!
   }

    func showAcceptAlert() {
        let alert = UIAlertController(title: "Proceed Wishlist", message: "Are you sure you want to proceed with this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_)in
            print("User click Approve button")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    func showDeleteAlert() {
        let alert = UIAlertController(title: "Delete Wishlist", message: "Are you sure you want to delete this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(_)in
            print("User click Approve button")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

}
