//
//  PurchaseDetailViewController.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import UIKit

class PurchaseDetailViewController: UIViewController {
    
    var items: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        self.view = PurchaseDetailView(viewModel: PurchaseDetailViewModel(), viewController: self)
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
