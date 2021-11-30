//
//  PurchaseOverviewViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 19/11/21.
//

import UIKit

class PurchaseOverviewViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel = PurchaseOverviewViewModel()
    
    // MARK: - Container
    var itemContainer: Items?
    var budgetUsedContainer: [BudgetUsed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendReceivedDataToVM()
        // Do any additional setup after loading the view.
    }
    
    private func sendReceivedDataToVM() {
        if let itemReceived = itemContainer {
            viewModel.itemWantToBuy = itemReceived
        }
        if let budgetUsedReceived = budgetUsedContainer {
            viewModel.budgetUsed = budgetUsedReceived
        }
    }
    
    override func loadView() {
        self.view = PurchaseOverviewView(viewModel: viewModel, viewController: self)
        
    }
}
