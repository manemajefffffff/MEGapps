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
    @IBOutlet weak var imageChevronRight: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    var otherBudget: Budget? {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cellView.layer.shadowRadius = 2.0
        cellView.layer.shadowOpacity = 0.4
        cellView.layer.masksToBounds = false
    }
    
    private func setData() {
        self.labelProductName.text = "\(otherBudget?.name ?? "budget name")"
        self.labelProductPrice.text = "\(otherBudget?.amount ?? 0)"
    }
}
