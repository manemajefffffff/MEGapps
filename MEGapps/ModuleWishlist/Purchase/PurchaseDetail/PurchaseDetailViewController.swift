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
    weak var delegate: updateViewProtocol?
    private var purchaseDetailView: PurchaseDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        viewModel.item = itemsPD!
        viewModel.calculate()
        purchaseDetailView = PurchaseDetailView(viewModel: viewModel, viewController: self)
        self.view = purchaseDetailView
    }

    func showAcceptAlert() {
        let alert = UIAlertController(title: "Proceed Wishlist", message: "Are you sure you want to proceed with this wishlist?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_)in
            print("User click Accept button")
            self.viewModel.acceptAccWishlist()
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
            self.viewModel.deleteAccWishlist()
//            self.delegate?.updateSavingListView()
//            self.navigationController?.popToRootViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        

        self.present(alert, animated: true, completion: {
            print("completion block B")
        })
    }
    
    func prioritizeAlert() {
        let alert = UIAlertController(title: "Unable to Prioritize", message: "You have more than 1 prioritized item!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accept", style: .destructive, handler: {(_)in
            print("User click Accept button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block C")
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
    
    func changePriorityStatus() {
        self.viewModel.changePriorityStatus()
    }
    
    func budgetsDeducted() {
        let viewController = PurchaseOverviewViewController()
        viewController.itemContainer = viewModel.item
        viewController.hidesBottomBarWhenPushed = true
//        viewController.navigationController?.navigationItem.leftBarButtonItem = nil
//        viewController.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
//        viewController.navigationController?.isNavigationBarHidden = true
        
//        let navPurcOverview: UINavigationController = UINavigationController(rootViewController: viewController)
//        navPurcOverview.modalPresentationStyle = .fullScreen
//
//        self.present(navPurcOverview, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
        
    func othersBudget() {
        // navigate ke page others budget
        // Ini insufficient view controllernya tunggu ada
//        let viewController = InsufficientAmountViewController()
//        viewController.itemsIA = self.itemsPD
//        let navInsufficientAmt: UINavigationController = UINavigationController(rootViewController: viewController)
//        navInsufficientAmt.modalPresentationStyle = .fullScreen
//        self.present(navInsufficientAmt, animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "AllocateOtherBudget", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "allocateOtherBudgetPage") as? AllocateOtherBudgetView else {
            fatalError("no view")
        }
        viewController.itemContainer = viewModel.item
        viewController.insufficientAmountContainer = viewModel.insufficientAmt
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func editWishlistPage() {
        let storyboard = UIStoryboard(name: "WishlistAdd", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "wishlistAddSB") as? WishlistAddView
        else {
            fatalError("VC not found")
        }
        viewController.oldWishlistData = viewModel.item
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension PurchaseDetailViewController: sendEditedWishlistBackDelegate {
    func send(_ editedItem: Items) {
        print("edited item send back")
        self.viewModel.item = editedItem
    }
}
