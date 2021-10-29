//
//  PurchaseProductViewContoller.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation
import UIKit

class PurchaseProductViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        self.view = PurchaseProductView(viewModel: PurchaseProductViewModel(), viewController: self)
    }

}
