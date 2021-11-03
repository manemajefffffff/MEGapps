//
//  PurchaseSameItemTableViewCell.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 29/10/21.
//

import UIKit

class PurchaseSameItemTableViewCell: UITableViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductDeadline: UILabel!
    
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
