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
    
    var newData: Budget? {
        didSet {
            setData()
        }
    }
    
    func setData(){
        labelProductName.text = newData?.name
        labelProductPrice.text = "\(newData?.amount)"
        labelInitialBudget.text = "\(newData?.amount)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
//        cellView.layer.shadowColor = UIColor.lightGray.cgColor
//        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        cellView.layer.shadowRadius = 2.0
//        cellView.layer.shadowOpacity = 0.4
//        cellView.layer.masksToBounds = false
    }
    
}
