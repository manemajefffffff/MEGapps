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
    @IBOutlet weak var deleteBtn: UIButton!
    
    // MARK: - ViewModel
    private let viewModel = AddEditBudgetViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Variables
    var oldBudgetData: Budget?
    
    // MARK: - Delegate
    weak var delegate: AddEditBudgetDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manageShadowView()
        manageDeleteBtn()
        setOldBudgetData()
        setData()
    }
    
    // MARK: - IBAction
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBudget(_ sender: Any) {
        let emptyData = checkEmptyField()
        if emptyData == false {
            viewModel.saveBudget(name: budgetNameTF.text ?? "", amount: Int64(budgetAmtTF.text ?? "0") ?? 0)
            dismiss(animated: true, completion: {
                self.delegate?.refreshData()
            })
        }
    }
    
    @IBAction func deleteBudget(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Budget", message: "Are you sure you want to delete this budget?", preferredStyle: .alert)
        
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
        viewModel.$oldBudgetData
            .sink { [weak self] oldBudgetData in
                if let budget = oldBudgetData {
                    self?.manageDeleteBtn(hidden: false)
                    self?.budgetNameTF.text = "\(budget.name ?? "")"
                    self?.budgetAmtTF.text = "\(budget.amount)"
                    self?.title = "Edit Other Budget"
                }
            }.store(in: &anyCancellable)
    }
    
    fileprivate func setOldBudgetData() {
        if let data = oldBudgetData {
            viewModel.oldBudgetData = data
        }
    }
    
    private func manageDeleteBtn(hidden: Bool = true) {
        deleteBtn.isHidden = hidden
    }
    
    private func checkEmptyField() -> Bool{
        if budgetNameTF.text == "" {
            showAlert(message: "You have not inputted Budget Name")
            return true
        } else if budgetAmtTF.text == "" {
            showAlert(message: "You have not inputted Budget Amount")
            return true
        }
        return false
    }
    
    private func showAlert(message: String) {
        let myAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}
