//
//  AddEditBudgetViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 02/11/21.
//

import UIKit
import Combine

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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manageShadowView()
//        subscribe()
    }
    
    // MARK: - IBAction
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBudget(_ sender: Any) {
        viewModel.saveBudget(name: budgetNameTF.text ?? "", amount: Int64(budgetAmtTF.text ?? "0") ?? 0)
    }
    
    @IBAction func deleteBudget(_ sender: Any) {
        viewModel.deleteBudget()
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
    
    private func subscribe() {
        viewModel.$oldBudgetData
            .sink { [weak self] _ in
                self?.setData()
            }.store(in: &anyCancellable)
    }
    
    private func setData() {
        budgetNameTF.text = "\(viewModel.oldBudgetData.name ?? "")"
        budgetAmtTF.text = "\(viewModel.oldBudgetData.amount)"
    }
}
