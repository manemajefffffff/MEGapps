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
        viewModel.item = itemsPD!
        self.view = PurchaseDetailView(viewModel: viewModel, viewController: self)
   }
    
    func showAlert() {
        
    }

    func showAcceptAlert() {
        let alert = UIAlertController(title: "Accept", message: "Please Select an Option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_)in
            print("User click Accept button")
            self.viewModel.acceptAccWishlist()
            self.savingsSufficiency()
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    func showDeleteAlert() {
        let alert = UIAlertController(title: "Delete", message: "Please Select an Option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {(_)in
            print("User click Delete button")
            self.viewModel.deleteAccWishlist()
            self.navigationController?.popToRootViewController(animated: true)
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func savingsSufficiency() {
        if viewModel.isSufficient == true {
            budgetsDeducted()
        } else {
            othersBudget()
        }
    }
    
    func budgetsDeducted() {
        // navigate ke page budgets deducted
        let viewController = PurchaseOverviewViewController()
        viewController.itemsBD = self.itemsPD
        let navPurcOverview: UINavigationController = UINavigationController(rootViewController: viewController)
        navPurcOverview.modalPresentationStyle = .fullScreen
        self.present(navPurcOverview, animated: true, completion: nil)
    }
    
    func othersBudget() {
        // navigate ke page others budget
        // Ini insufficient view controllernya tunggu ada
//        let viewController = InsufficientAmountViewController()
//        viewController.itemsIA = self.itemsPD
//        let navInsufficientAmt: UINavigationController = UINavigationController(rootViewController: viewController)
//        navInsufficientAmt.modalPresentationStyle = .fullScreen
//        self.present(navInsufficientAmt, animated: true, completion: nil)
    }

}
