//
//  SavingsAddViewController.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 02/11/21.
//

import Foundation
import UIKit

class SavingsAddViewController: UIViewController {
     
    // MARK: -  Outlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    func setupUI() {
        amountTextField.layer.cornerRadius = 10
        
        amountTextField.layer.borderColor = UIColor.lightGray.cgColor
        amountTextField.layer.borderWidth =  0.25
        
        amountTextField.layer.shadowOpacity = 0.5
        amountTextField.layer.shadowColor = UIColor.lightGray.cgColor
        amountTextField.layer.shadowRadius = 4.0
        amountTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        amountTextField.layer.masksToBounds = false
        
        amountTextField.setLeftPadding(20)
    }
}

// MARK: - Text Field Extension
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
