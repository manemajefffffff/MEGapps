//
//  OtherBudgetTableViewCell.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 27/10/21.
//

import UIKit

class OtherBudgetTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var labelInitialBudget: UILabel!
    @IBOutlet weak var labelBudgetUsed: UILabel!
    @IBOutlet weak var labelBudgetLeft: UILabel!
    @IBOutlet weak var progressBar: CustomProgressBar!
    
    var otherBudget: Budget? {
        didSet {
            calculateData()
            setData()
        }
    }
    
    var budgetUsed = [TrItemBudget]()
    var total: Int64 = 0
    var percent: Int64 = 0
    
    func setData() {
        labelProductName.text = otherBudget?.name
        if let labelPrice = otherBudget?.amount {
            labelProductPrice.text = "Rp. \(labelPrice)"
            labelInitialBudget.text = "Rp. \(labelPrice)"
            labelBudgetLeft.text = "Rp. \(labelPrice - total)"
        }
        labelBudgetUsed.text = "Rp. \(total)"
    }
    
    func calculateData() {
        total = 0
        if let budgetUsed = otherBudget?.trItemBudget?.allObjects as? [TrItemBudget] {
            for object in budgetUsed {
                total = object.amount + total
            }
        }
        
        if let budgetPrice = otherBudget?.amount {
            if budgetPrice > 0 {
                percent = total/budgetPrice
            }
            progressBar.progress = CGFloat(percent)
            print("percent", percent)
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
//        cellView.layer.shadowColor = UIColor.lightGray.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        cellView.layer.shadowRadius = 2.0
//        cellView.layer.shadowOpacity = 0.4
//        cellView.layer.masksToBounds = false
    }
    
//    private func setData() {
//        self.labelProductName.text = "\(otherBudget?.name ?? "budget name")"
//        self.labelProductPrice.text = "\(otherBudget?.amount ?? 0)"
//    }
}
