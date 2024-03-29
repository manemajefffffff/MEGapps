//
//  PurchaseCategoryView.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 28/10/21.
//

import Foundation
import UIKit

protocol receivedDataDelegate: AnyObject {
    func passData(data: String)
}

class PurchaseCategoryView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    let categories = ["Collection Items", "Technologies", "Travelling", "Gaming", "Fashion"]
    var selectedCategories: String = ""
    private let viewModel = PurchaseCategoryViewModel()
    weak var delegate: receivedDataDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableView.contentSize.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    // MARK: - Functions
    
    func setupUI() {
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.layer.borderWidth = 0.5

        let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 382, height: 400))
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

    // MARK: - Actions
    @IBAction func dismissCategory(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
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
            selectedCategories = categories[indexPath.row]
            delegate?.passData(data: selectedCategories)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .none
        }
    }
}
