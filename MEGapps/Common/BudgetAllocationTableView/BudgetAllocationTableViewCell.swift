//
//  BudgetAllocationTableViewCell.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 28/10/21.
//

import UIKit

class BudgetAllocationTableViewCell: UITableViewCell {
    
    //MARK: - Outlet
    @IBOutlet weak var budgetName: UILabel!
    @IBOutlet weak var budgetAmountRp: UILabel!
    @IBOutlet weak var budgetAmount: UILabel!
    
    @IBOutlet weak var budgetUsedLabel: UILabel!
    @IBOutlet weak var budgetUsedRp: UILabel!
    @IBOutlet weak var budgetUsedAmt: UILabel!
    
    @IBOutlet weak var budgetLeftLabel: UILabel!
    @IBOutlet weak var budgetLeftRp: UILabel!
    @IBOutlet weak var budgetLeftAmt: UILabel!
    
    let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // MARK: - Line
        self.lineView.layer.borderWidth = 1.0
        self.lineView.layer.borderColor = UIColor.black.cgColor
        self.addSubview(self.lineView)
        
        // MARK: - Auto Layout
        self.budgetName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.budgetName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.budgetName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12)
        ])
        self.budgetAmountRp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetAmountRp.topAnchor.constraint(equalTo: self.budgetName.bottomAnchor, constant: 8),
            self.budgetAmountRp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.budgetAmountRp.trailingAnchor.constraint(equalTo: self.budgetAmount.leadingAnchor, constant: 6)
        ])
        self.budgetAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetAmount.topAnchor.constraint(equalTo: self.budgetName.bottomAnchor, constant: 8),
            self.budgetAmount.leadingAnchor.constraint(equalTo: self.budgetAmountRp.trailingAnchor, constant: 6),
            self.budgetAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        self.budgetUsedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetUsedLabel.topAnchor.constraint(equalTo: self.budgetAmountRp.bottomAnchor, constant: 12),
            self.budgetUsedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.budgetUsedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        self.budgetUsedRp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetUsedRp.topAnchor.constraint(equalTo: self.budgetUsedLabel.bottomAnchor, constant: 8),
            self.budgetUsedRp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.budgetUsedRp.trailingAnchor.constraint(equalTo: self.budgetUsedAmt.leadingAnchor, constant: 6)
        ])
        self.budgetUsedAmt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetUsedAmt.topAnchor.constraint(equalTo: self.budgetUsedLabel.bottomAnchor, constant: 8),
            self.budgetUsedAmt.leadingAnchor.constraint(equalTo: self.budgetUsedRp.trailingAnchor, constant: 6),
            self.budgetUsedAmt.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.lineView.topAnchor.constraint(equalTo: self.budgetUsedAmt.bottomAnchor, constant: 12),
            self.lineView.bottomAnchor.constraint(equalTo: self.lineView.topAnchor, constant: 1),
            self.lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.budgetLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetLeftLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 12),
            self.budgetLeftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.budgetLeftLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        self.budgetLeftRp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetLeftRp.topAnchor.constraint(equalTo: self.budgetLeftLabel.bottomAnchor, constant: 8),
            self.budgetLeftRp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.budgetLeftRp.trailingAnchor.constraint(equalTo: self.budgetLeftAmt.leadingAnchor, constant: 6),
            self.bottomAnchor.constraint(equalTo: self.budgetLeftRp.bottomAnchor, constant: 12)
        ])
        self.budgetLeftAmt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetLeftAmt.topAnchor.constraint(equalTo: self.budgetLeftLabel.bottomAnchor, constant: 8),
            self.budgetLeftAmt.leadingAnchor.constraint(equalTo: self.budgetLeftRp.trailingAnchor, constant: 6),
            self.budgetLeftAmt.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
