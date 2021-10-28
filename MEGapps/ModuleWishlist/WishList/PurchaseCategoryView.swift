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
    
    
    // MARK: - Variables
    let categories = ["Technologies", "Travelling", "Scuba Diving", "Gaming", "Fashion"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    // MARK: - Functions
    
    func setupUI() {
        //for table view border
        tableView.layer.cornerRadius = 5
        tableView.layer.cornerRadius = 5
        let shadowPath = UIBezierPath(roundedRect: tableView.bounds, cornerRadius: 5)
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor.red.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        tableView.layer.shadowOpacity = 0.25
        tableView.layer.shadowPath = shadowPath.cgPath
    }
    
}

// MARK: - Table View

extension PurchaseCategoryView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
