//
//  BudgetAllocationTableViewCell.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 28/10/21.
//

import UIKit

class BudgetAllocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var budgetName: UILabel!
    @IBOutlet weak var budgetAmount: UILabel!
    @IBOutlet weak var budgetUsedAmt: UILabel!
    @IBOutlet weak var budgetLeftAmt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
