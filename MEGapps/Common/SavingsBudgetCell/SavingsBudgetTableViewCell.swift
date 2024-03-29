//
//  SavingsBudgetTableViewCell.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 28/10/21.
//

import UIKit

class SavingsBudgetTableViewCell: UITableViewCell {
    
// MARK: - Outlets
    @IBOutlet weak var viewSavingsBudgetCell: UIView!
    @IBOutlet weak var imageStar: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductName2: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    
// MARK: - Variables
    var newData: Items? {
        didSet {
            setData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        self.viewSavingsBudgetCell.layer.cornerRadius = 16.0
        self.viewSavingsBudgetCell.layer.shadowColor = UIColor.black.cgColor
        self.viewSavingsBudgetCell.layer.shadowRadius = 2.0
        self.viewSavingsBudgetCell.layer.shadowOpacity = 0.4
        self.viewSavingsBudgetCell.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.viewSavingsBudgetCell.layer.masksToBounds = false
    }
    
    private func setData() {
        if let prodName = newData?.name {
            labelProductName.text = "\(prodName)"
            labelProductName2.text = "\(prodName)"
        }
        if let prodPrice = newData?.price {
            labelProductPrice.text = "Rp. \(prodPrice.formattedWithSeparator)"
        }
        if let prodPriority = newData?.isPrioritize {
            if prodPriority == true {
                imageStar.isHidden = false
                labelProductName.isHidden = false
                labelProductName2.isHidden = true
            }
            else {
                imageStar.isHidden = true
                labelProductName.isHidden = true
                labelProductName2.isHidden = false
            }
        }
    }
}
