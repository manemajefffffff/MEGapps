//
//  AllocateOtherBudgetTableViewCell.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import UIKit

class AllocateOtherBudgetTableViewCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAvailabelLabel: UILabel!
    @IBOutlet weak var budgetToUseTextField: UITextField!
    
    // MARK: - Variable
    var id: Int = -1
    var budgetAmountToUse: Int64 = 0
    var budget: BudgetUsed? {
        didSet {
            setData()
        }
    }
    
    // MARK: -
    weak var delegate: ChangeBudgetUsedAmountProtocol?
    
    // MARK: - Closure
//    var changeAmoutBudgetUsed: ((_ amount: Int64, _ index: Int) -> Void)?
//    var deleteBudgetUsed: ((_ index: Int) -> Void)?


    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupToolbar()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        budgetNameLabel.text = "Budget Name"
        budgetAvailabelLabel.text = "Rp. 0s"
    }
   
    // MARK: - IBAction
    @IBAction func deleteBudgetCell(_ sender: Any) {
        print("button delete tap")
//        deleteBudgetUsed!(id)
        budgetAmountToUse = 0
        delegate?.deleteBudgetUsed(index: id)
    }
    
    @IBAction func changeAmountWillUsed(_ sender: Any) {
        if let amount = Int64("\(budgetToUseTextField.text ?? "0")") {
            if amount <= 0 {
                self.budgetAmountToUse = 0
                delegate?.changeAmountWillUsed(amount: budgetAmountToUse, index: id)
            } else if amount > budget?.budget?.amount ?? 0 {
                self.budgetAmountToUse = budget?.budget?.amount ?? 0
                delegate?.changeAmountWillUsed(amount: budgetAmountToUse, index: id)
            } else {
                self.budgetAmountToUse = amount
                delegate?.changeAmountWillUsed(amount: budgetAmountToUse, index: id)
            }
        } else {
            self.budgetAmountToUse = 0
            delegate?.changeAmountWillUsed(amount: budgetAmountToUse, index: id)
        }
    }

    
    // MARK: Function
    private func setupToolbar() {
        // Create a toolbar
        let bar = UIToolbar()
        // Create a done button with an action to trigger our function to dismiss the keyboard
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        // Create a felxible space item so that we can add it around in toolbar to position our done button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Add the created button items in the toobar
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        // Add the toolbar to our textfield
        budgetToUseTextField.inputAccessoryView = bar
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    private func setData() {
        budgetNameLabel.text = "\(budget?.budget?.name ?? "Budget Name")"
        if let budget = budget?.budget?.amount {
            budgetAvailabelLabel.text = "\(FormatNumberHelper.formatNumber(price: budget))"

        }
        if budget!.amountUsed > 0 {
            budgetToUseTextField.text = "\(budget?.amountUsed ?? 0)"
        }
    }
}
