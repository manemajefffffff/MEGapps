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
    
    func formatNumber(price: Int64) -> String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let formattedPrice = formatter.string(from: price as NSNumber) {
            return "Rp. \(formattedPrice)"
        }
        return "Rp. 0"
    }
    
    func calculateData() {
        total = 0
        var percent: Double = 0.0
        if let budgetUsed = otherBudget?.trItemBudget?.allObjects as? [TrItemBudget] {
            for object in budgetUsed {
                total = object.amount + total
            }
        }
        
        if let budgetPrice = otherBudget?.amount {
            
            print("budgetPrice", budgetPrice)
            if budgetPrice > 0 {
                percent = Double(total)/Double(budgetPrice)
            }
            progressBar.progress = CGFloat(percent)
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
