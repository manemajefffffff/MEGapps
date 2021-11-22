//
//  ProductInformationTableViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 28/10/21.
//

import UIKit

protocol ProductInformationTVCProtocol: AnyObject {
    func changepiHeight(piHeight: CGFloat)
}

class ProductInformationTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var deadlineLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    
    // MARK: - Variables
    weak var delegate: ProductInformationTVCProtocol?
    var item: WishlistAdd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataToUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        delegate?.changepiHeight(piHeight: self.tableView.contentSize.height)
    }
    
    private func setDataToUI() {
        if let currentData = item {
            productNameLbl.text = currentData.name
            productPriceLbl.text = "\(currentData.price)"
            categoryNameLbl.text = currentData.category
            deadlineLbl.text = "\(currentData.deadline)"
            reasonLbl.text = currentData.reason
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
}
