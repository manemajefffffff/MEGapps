//
//  SavingsHistoryTableViewCell.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 02/11/21.
//

import UIKit

class SavingsHistoryTableViewCell: UITableViewCell {

//MARK: - Outlets
    @IBOutlet weak var viewHistorySavingsCell: UIView!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
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
