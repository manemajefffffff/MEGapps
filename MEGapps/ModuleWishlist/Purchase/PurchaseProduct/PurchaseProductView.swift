//
//  PurchaseProductView.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation
import UIKit

class PurchaseProductView: UIView {
    // MARK: - MVVM
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    // MARK: - Outlet
    let scrollView = UIScrollView()
    let contentView = UIView()
    var purchaseProductDetailView: PurchaseProductDetailView
    let budgetAllocationUsedLabel = UILabel()
    var budgetAllocationUsedView: BudgetAllocationUsedView
    let allocateOtherBudgetButton = UIButton()
    let purchaseItemButton = UIButton()
    
    // MARK: - Lifecycle
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        self.purchaseProductDetailView = PurchaseProductDetailView(viewModel: viewModel, viewController: viewController)
        self.budgetAllocationUsedView = BudgetAllocationUsedView(viewModel: viewModel, viewController: viewController)
        super.init(frame: .zero)
        
        self.setupScrollView()
        self.setup()
        self.style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setupScrollView() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: 0),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0)
        ])
    }

    func setup() {
        self.contentView.addSubview(purchaseProductDetailView)
        self.contentView.addSubview(budgetAllocationUsedLabel)
        self.contentView.addSubview(budgetAllocationUsedView)
        self.contentView.addSubview(allocateOtherBudgetButton)
        self.contentView.addSubview(purchaseItemButton)
    }

    func style() {
        // Note: Testing, Nanti color diganti yang bener
        self.backgroundColor = UIColor(named: "BackgroundColor")
        
        purchaseProductDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            purchaseProductDetailView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            purchaseProductDetailView.bottomAnchor.constraint(equalTo: self.budgetAllocationUsedLabel.topAnchor, constant: -16),
            purchaseProductDetailView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            purchaseProductDetailView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
        budgetAllocationUsedLabel.text = "Budget Allocation Used:"
        budgetAllocationUsedLabel.font = .systemFont(ofSize: 15, weight: .regular)
        budgetAllocationUsedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            budgetAllocationUsedLabel.topAnchor.constraint(equalTo: self.purchaseProductDetailView.bottomAnchor, constant: 16),
            budgetAllocationUsedLabel.bottomAnchor.constraint(equalTo: self.budgetAllocationUsedView.topAnchor, constant: -16),
            budgetAllocationUsedLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            budgetAllocationUsedLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])

        budgetAllocationUsedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            budgetAllocationUsedView.topAnchor.constraint(equalTo: self.budgetAllocationUsedLabel.bottomAnchor, constant: 16),
            budgetAllocationUsedView.bottomAnchor.constraint(equalTo: self.allocateOtherBudgetButton.topAnchor, constant: -16),
            budgetAllocationUsedView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            budgetAllocationUsedView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
        allocateOtherBudgetButton.setTitle("   Allocate Other Budget", for: .normal)
        allocateOtherBudgetButton.setTitleColor(.systemBlue, for: .normal)
        allocateOtherBudgetButton.backgroundColor = .systemRed
        allocateOtherBudgetButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        allocateOtherBudgetButton.contentHorizontalAlignment = .left
        allocateOtherBudgetButton.layer.cornerRadius = 10
        allocateOtherBudgetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allocateOtherBudgetButton.heightAnchor.constraint(equalToConstant: 49),
            allocateOtherBudgetButton.topAnchor.constraint(equalTo: self.budgetAllocationUsedView.bottomAnchor, constant: 16),
            allocateOtherBudgetButton.bottomAnchor.constraint(equalTo: self.purchaseItemButton.topAnchor, constant: -16),
            allocateOtherBudgetButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            allocateOtherBudgetButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
        
        purchaseItemButton.setTitle("Purchase Item", for: .normal)
        purchaseItemButton.backgroundColor = .systemRed
        purchaseItemButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        purchaseItemButton.layer.cornerRadius = 10
        purchaseItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            purchaseItemButton.heightAnchor.constraint(equalToConstant: 49),
            purchaseItemButton.topAnchor.constraint(equalTo: self.allocateOtherBudgetButton.bottomAnchor, constant: 16),
            purchaseItemButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50),
            purchaseItemButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            purchaseItemButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Purchase Product Segment
class PurchaseProductDetailView: UIView {
    // MARK: - Variable
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    // MARK: - Outlet
    let tableView: PurchaseProductDetailTableView
    
    // MARK: - Lifecycle
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        self.tableView = PurchaseProductDetailTableView(viewModel: viewModel, viewController: viewController)
        super.init(frame: .zero)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setup() {
        self.addSubview(tableView)
        self.tableView.frame = self.bounds
        self.tableView.layer.cornerRadius = 10
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}

class PurchaseProductDetailTableView: ContentSizedTableView, UITableViewDataSource, UITableViewDelegate {
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    // MARK: - Lifecycle
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero, style: .plain)
        
        self.setup()
        self.style()
        
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.register(CustomDoubleTableViewCell.self, forCellReuseIdentifier: CustomDoubleTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setup() {
        self.dataSource = self
        self.delegate = self
    }

    func style() {
        //
    }
}

extension PurchaseProductDetailTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = "Nintendo Switch OLED"
            cell.textLabel!.font = .systemFont(ofSize: 17, weight: .semibold)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = "Rp. 5.999.999"
            return cell
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CustomDoubleTableViewCell.identifier, for: indexPath) as? CustomDoubleTableViewCell {
                cell.textLabel!.text = "Product Category"
                cell.rightTextLabel.text = "Gaming"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel!.text = "NaN"
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CustomDoubleTableViewCell.identifier, for: indexPath) as? CustomDoubleTableViewCell {
                cell.textLabel!.text = "Product Deadline"
                cell.rightTextLabel.text = "January 30, 2021"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel!.text = "NaN"
                return cell
            }
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = "I have completed all the games i owned now, I want to try new games."
            cell.textLabel!.numberOfLines = 0
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = "NaN"
            return cell
        }
    }
}
// MARK: - Budget Allocation Segment
class BudgetAllocationUsedView: UIView {
    // MARK: - Variable
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    // MARK: - Outlet
    let tableView: BudgetAllocationUsedTableView
    
    // MARK: - Lifecycle
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        self.tableView = BudgetAllocationUsedTableView(viewModel: viewModel, viewController: viewController)
        super.init(frame: .zero)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setup() {
        self.addSubview(tableView)
        self.tableView.frame = self.bounds
//        self.tableView.layer.cornerRadius = 10
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}

class BudgetAllocationUsedTableView: ContentSizedTableView, UITableViewDataSource, UITableViewDelegate {
    private var viewModel: PurchaseProductViewModel
    private var viewController: PurchaseProductViewController
    
    // MARK: - Lifecycle
    init(viewModel: PurchaseProductViewModel, viewController: PurchaseProductViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero, style: .plain)
        
        self.setup()
        self.style()
        
        self.register(UINib.init(nibName: "BudgetAllocationTableViewCell", bundle: nil), forCellReuseIdentifier: "BudgetAllocationTableViewCell")
        
        self.isScrollEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setup() {
        self.dataSource = self
        self.delegate = self
    }

    func style() {
        //
    }
}

extension BudgetAllocationUsedTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetAllocationTableViewCell", for: indexPath)
        return cell
    }
}

// MARK: - Custom cell class
class CustomDoubleTableViewCell: UITableViewCell {
    static let identifier = "CustomDoubleTableViewCell"
    
    lazy var rightTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    func setupCell(rightValue: String) {
        self.rightTextLabel.text = rightValue
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "PureWhite")
        textLabel?.textAlignment = .left
        textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        self.addSubview(rightTextLabel)
        rightTextLabel.textAlignment = .right
        rightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightTextLabel.topAnchor.constraint(equalTo: self.topAnchor),
            rightTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            rightTextLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
