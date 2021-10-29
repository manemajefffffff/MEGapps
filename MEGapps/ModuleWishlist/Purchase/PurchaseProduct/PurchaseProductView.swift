//
//  PurchaseProductView.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation
import UIKit

class PurchaseProductView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    let tableView = ContentSizedTableView()
    var dummyData: [DoubleClassModel]
    
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        self.dummyData = DoubleClassModel.initDummyData()
        super.init(frame: .zero)
        
        self.setup()
        self.style()
        self.setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        //
    }

    func style() {
        self.backgroundColor = .systemRed// UIColor(named: "BabyPowder")
        viewController.navigationItem.title = "Purchase Product"
        let rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        let attributes: [NSAttributedString.Key: Any] = [ .font: UIFont.boldSystemFont(ofSize: 17) ]
        rightBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        rightBarButtonItem.tintColor = UIColor(named: "NavigationItemsGreen")
        viewController.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupTableView() {
        self.addSubview(tableView)
        tableView.register(CustomDoubleTableViewCell.self, forCellReuseIdentifier: CustomDoubleTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = self.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            // self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}

extension PurchaseProductView {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dummyData.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Allocate Other Budget"
            cell.textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            cell.textLabel?.textColor = UIColor(named: "ButtonTextGreen")
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CustomDoubleTableViewCell.identifier, for: indexPath) as? CustomDoubleTableViewCell {
                cell.textLabel?.text = "Cell \(dummyData[indexPath.row].leftVal!)"
                cell.setupCell(rightValue: "\(dummyData[indexPath.row].rightVal!)")
                return cell
            }
        }
        fatalError("could not dequeReuseableCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dummyData.append(DoubleClassModel(leftVal: "A", rightVal: "Rp999.999"))
        print("Hello")
        print(dummyData.count)
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
