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
    @IBOutlet weak var wishlistContainerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
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
    func setupUI() {
        wishlistContainerView.layer.shadowColor = UIColor.black.cgColor
        wishlistContainerView.layer.shadowRadius = 2
        wishlistContainerView.layer.shadowOpacity = 0.3
        wishlistContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        wishlistContainerView.layer.masksToBounds = false
    }
}
