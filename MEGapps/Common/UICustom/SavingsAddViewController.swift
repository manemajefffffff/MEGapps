//
//  SavingsAddViewController.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 02/11/21.
//

import Foundation
import UIKit
import Combine

class SavingsAddViewController: UIViewController {
    
    // MARK: - ViewModel
    private let savingsAddVM = SavingsAddViewModel()
    var anyCancellable = Set<AnyCancellable>()
     
    // MARK: -  Outlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    // MARK: - Variable
    let formatter = DateFormatter()
    let currentTime: Date = Date()
    var onViewWillDisappear: (()->())?
    var emptyState = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        retrieveData()
    }
    
    // MARK: - Actions
    @IBAction func dismissPage(_ sender: Any) {
        onViewWillDisappear?()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        saveSavingsAmount()
        onViewWillDisappear?()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Functions
    func saveSavingsAmount() {
        self.savingsAddVM.newAmount = Int(amountTextField.text ?? "") ?? 0
        self.savingsAddVM.saveSavingsAmount()
    }
    
    func retrieveData() {
        savingsAddVM.fetchData()
    }
    
    func emptyCheck() {
        if amountTextField.text == ""{
            let alert = UIAlertController(title: "Error", message: "Please enter a valid amount.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
            self.present(alert, animated: true, completion: nil)
            emptyState = true
        }
    }
    
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
        
        getTodaysDate(label: dateLabel)
    }
    
    func getTodaysDate(label: UILabel) {
        formatter.dateFormat = "dd MMMM yyyy, HH:mm"
        label.text = "\(formatter.string(from: currentTime))"
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
