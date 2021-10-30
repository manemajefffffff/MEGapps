//
//  PurchaseCategoryView.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 28/10/21.
//

import Foundation
import UIKit

class PurchaseCategoryView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    let categories = ["Technologies", "Travelling", "Scuba Diving", "Gaming", "Fashion"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableView.contentSize.height
    }
    
    // MARK: - Functions
    
    func setupUI() {
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.layer.borderWidth = 1.0

        let containerView: UIView = UIView(frame: self.tableView.frame)
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 2

        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        self.view.addSubview(containerView)
        containerView.addSubview(tableView)
    }
    
}

// MARK: - Table View

extension PurchaseCategoryView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") else {
            fatalError("No cell")
        }
        
        var content =  cell.defaultContentConfiguration()
        content.text = categories[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
                cell.accessoryType = .checkmark

        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
                cell.accessoryType = .none

        }
    }
}
