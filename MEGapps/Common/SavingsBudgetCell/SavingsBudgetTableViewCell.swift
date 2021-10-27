//
//  SavingsBudgetTableViewCell.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 27/10/21.
//

import UIKit

class SavingsBudgetTableViewCell: UITableViewCell {

//MARK: - Outlets
    @IBOutlet weak var imageStar: UIImageView!
    @IBOutlet weak var imageChevronRight: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
