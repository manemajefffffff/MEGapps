//
//  AddEditBudgetViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 02/11/21.
//

import UIKit
import Combine

protocol AddEditBudgetDelegate: AnyObject {
    func refreshData()
}

class AddEditBudgetViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var budgetNameTF: UITextField!
    @IBOutlet weak var budgetAmtTF: UITextField!
    
    // MARK: - ViewModel
    private let viewModel = AddEditBudgetViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Variables
    var oldBudgetData: Budget? {
        didSet {
            if let data = oldBudgetData {
                viewModel.oldBudgetData = data
            }
        }
    }
    
    // MARK: - Delegate
    weak var delegate: AddEditBudgetDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manageShadowView()
        setData()
    }
    
    // MARK: - IBAction
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBudget(_ sender: Any) {
        viewModel.saveBudget(name: budgetNameTF.text ?? "", amount: Int64(budgetAmtTF.text ?? "0") ?? 0)
        dismiss(animated: true, completion: {
            self.delegate?.refreshData()
        })
    }
    
    @IBAction func deleteBudget(_ sender: Any) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this budget?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.viewModel.deleteBudget()
            self.dismiss(animated: true, completion: {
                self.delegate?.refreshData()
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true) {
            print("completion block")
        }
    }
    
    
    // MARK: - Functions
    private func manageShadowView() {
        self.budgetNameTF.layer.shadowColor = UIColor(hex: "bbbbbb")?.cgColor
        self.budgetNameTF.layer.shadowRadius = 0.4
        self.budgetNameTF.layer.shadowOpacity = 0.1
        self.budgetNameTF.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.budgetNameTF.layer.masksToBounds = false
        
        self.budgetAmtTF.layer.shadowColor = UIColor(hex: "bbbbbb")?.cgColor
        self.budgetAmtTF.layer.shadowRadius = 0.4
        self.budgetAmtTF.layer.shadowOpacity = 0.1
        self.budgetAmtTF.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.budgetAmtTF.layer.masksToBounds = false
    }
    
    private func setData() {
        if let budget = viewModel.oldBudgetData {
            budgetNameTF.text = "\(budget.name ?? "")"
            budgetAmtTF.text = "\(budget.amount)"
        }
    }
}
