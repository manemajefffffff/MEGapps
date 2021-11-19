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
    
    // MARK: - Variables

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = PurchaseOverviewView(viewModel: viewModel, viewController: self)
        
    }
}
