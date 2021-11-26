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
    }

    
    override func loadView() {
        viewModel.item = itemsPD!
        viewModel.calculate()
        self.view = PurchaseDetailView(viewModel: viewModel, viewController: self)
   }

    func showAcceptAlert() {
        let alert = UIAlertController(title: "Proceed Wishlist", message: "Are you sure you want to proceed with this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_)in
            print("User click Accept button")
            self.savingsSufficiency()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: {
            print("completion block A")
        })
    }

    func showDeleteAlert() {
        let alert = UIAlertController(title: "Delete Wishlist", message: "Are you sure you want to delete this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(_)in
            print("User click Delete button")
            self.savingsSufficiency()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        

        self.present(alert, animated: true, completion: {
            print("completion block B")
        })
    }

    func savingsSufficiency() {
            if viewModel.isSufficient == true {
                budgetsDeducted()
                print("sufficient")
                print("Go To Budgets Deducted Page")
            } else {
                othersBudget()
                print("insufficient")
                print("Go To Others budget Page")
            }
        }
    
    func budgetsDeducted() {
            // navigate ke page budgets deducted
            let viewController = PurchaseOverviewViewController()
//            viewController.itemsBD = self.itemsPD
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
