//
//  PurchaseAllocateBudgetTableViewCell.swift
//  MEGapps
//
//  Created by Arya Ilham on 29/10/21.
//

import UIKit

class PurchaseAllocateBudgetTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var budgetNameLbl: UILabel!
    @IBOutlet weak var budgetAvailLbl: UILabel!
    @IBOutlet weak var inputAmountTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func changeBudgetVariableValue(_ sender: Any) {
        // disini bakalan kirim perubahan input amount ke container/parents si budget
    }
}
