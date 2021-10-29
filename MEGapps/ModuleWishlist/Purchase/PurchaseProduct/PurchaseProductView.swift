//
//  PurchaseProductView.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation
import UIKit

class PurchaseProductView: UIView {
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)
        
        self.setup()
        self.style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        //
    }

    func style() {
        self.backgroundColor = .systemTeal// UIColor(named: "BabyPowder")
        //
    }
}
