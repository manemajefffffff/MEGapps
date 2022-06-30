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
    @IBOutlet weak var editButton: UIButton!
    
    var otherBudget: Budget? {
        didSet {
            setData()
        }
    }
    
    var budgetUsed = [TrItemBudget]()
    var total: Int64 = 0
    
    func setData() {
        labelProductName.text = otherBudget?.name
        if let labelPrice = otherBudget?.amount {
            labelProductPrice.text = formatNumber(price: labelPrice)
            labelInitialBudget.text = formatNumber(price: labelPrice)
            labelBudgetLeft.text = formatNumber(price: labelPrice - total)
        }
        labelBudgetUsed.text = formatNumber(price: total)
    }
    
    func formatNumber(price: Int64) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let formattedPrice = formatter.string(from: price as NSNumber) {
            return "Rp. \(formattedPrice)"
        }
        return "Rp. 0"
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func calculateData() {
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.total = 0
            var percent: Double = 0.0
            if let budgetUsed = (self.otherBudget?.trItemBudget?.allObjects as? [TrItemBudget])?.filter({ budget in
                Calendar.current.component(.month, from: budget.createdAt!) == currentMonth
            }) {
                for object in budgetUsed {
                    self.total = object.amount + self.total
                }
            }

            if let budgetPrice = self.otherBudget?.amount {
                print("budgetPrice", budgetPrice)
                if budgetPrice > 0 {
                    percent = Double(self.total)/Double(budgetPrice)
                }
                DispatchQueue.main.async {
                    self.progressBar.progress = CGFloat(percent)
                }
            }

        }
//
//        total = 0
//        var percent: Double = 0.0
//        if let budgetUsed = otherBudget?.trItemBudget?.allObjects as? [TrItemBudget] {
//            for object in budgetUsed {
//                total = object.amount + total
//            }
//        }
//
//        if let budgetPrice = otherBudget?.amount {
//
//            print("budgetPrice", budgetPrice)
//            if budgetPrice > 0 {
//                percent = Double(total)/Double(budgetPrice)
//            }
//            progressBar.progress = CGFloat(percent)
        }
}
