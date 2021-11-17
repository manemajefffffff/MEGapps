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
    
    weak var delegate: ProductInformationTVCProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        delegate?.changepiHeight(piHeight: self.tableView.contentSize.height)
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
