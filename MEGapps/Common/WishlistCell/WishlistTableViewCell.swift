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
    
    var newData: Items? {
        didSet {
            setData()
        }
    }
    
    func setData() {
        self.itemNameLbl.text = "\(self.newData?.name ?? "Item name")"
        self.statusIconImg.image = self.newData?.getImage()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm"        
        self.waitingEndDateLbl.text = dateFormatter.string(from: self.newData?.deadline ?? Date.distantPast)
    }
    
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
        statusIconImg.image = UIImage(systemName: "time")
        statusIconImg.tintColor = .systemRed
    }
    func setupUI() {
        wishlistContainerView.layer.shadowColor = UIColor.black.cgColor
        wishlistContainerView.layer.shadowRadius = 2
        wishlistContainerView.layer.shadowOpacity = 0.3
        wishlistContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        wishlistContainerView.layer.masksToBounds = false
    }
}
