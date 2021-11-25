//
//  AllocateOtherBudgetTableViewCell.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import UIKit

class AllocateOtherBudgetTableViewCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAvailabelLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBudgetCell(_ sender: Any) {
        print("button delete tap")
    }
    
}
