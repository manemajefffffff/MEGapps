//
//  SavingsBudgetTableViewCell.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 28/10/21.
//

import UIKit

class SavingsBudgetTableViewCell: UITableViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var viewSavingsBudgetCell: UIView!
    @IBOutlet weak var imageStar: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    
//MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
