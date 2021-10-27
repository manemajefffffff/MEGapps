//
//  WishlistTableViewCell.swift
//  MEGapps
//
//  Created by Arya Ilham on 26/10/21.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var statusIconImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var waitingEndDateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        itemNameLbl.text = "ItemName"
        waitingEndDateLbl.text = "Date"
        statusIconImg.image = UIImage(systemName: "clock")
    }
}
