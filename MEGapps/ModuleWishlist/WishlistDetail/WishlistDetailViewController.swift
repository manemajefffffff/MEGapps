//
//  WishlistDetailViewController.swift
//  MEGapps
//
//  Created by Aldo Febrian on 27/10/21.
//

import UIKit

class WishlistDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        self.view = WishlistDetailView(viewModel: WishlistDetailViewModel(), viewController: self)
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
