//
//  PurchaseOverviewView.swift
//  MEGapps
//
//  Created by Aldo Febrian on 12/11/21.
//

import Foundation
import UIKit
import Combine

class PurchaseOverviewView: UIView {
    // MARK: - MVVM
    private var viewModel: PurchaseOverviewViewModel
    private var viewController: PurchaseOverviewViewController
    var anyCancellable = Set<AnyCancellable>()

    // MARK: - Outlet
    let contentView = UIView()
    private let backView = UIView()
    private let purchaseImage = UIImageView()
    private let purchaseComplete = UILabel()
    private let itemName = UILabel()
    private let priceLabel = UILabel()
    private let priceAmountLabel = UILabel()
    private let dueDateLabel = UILabel()
    private let dueDateAmountLabel = UILabel()
    private let categoryLabel = UILabel()
    private let categotyAmountLabel = UILabel()
    private let lineView = UIView()
    private let budgetAllocationLabel = UILabel()
    private let savingLabel = UILabel()
    private let savingAmount = UILabel()
    private let doneButton = UIButton()

    // MARK: - Lifecycle
    init(viewModel: PurchaseOverviewViewModel, viewController: PurchaseOverviewViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)
        
        self.setup()
        self.style()
        
        subscribe()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    private func subscribe() {
        viewModel.$itemWantToBuy
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setItemData()
            }.store(in: &anyCancellable)
        
        viewModel.$budgetUsed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setBudgetUsedData()
            }.store(in: &anyCancellable)
    }
    
    private func setItemData() {
        if let item = viewModel.itemWantToBuy {
            itemName.text = "\(item.name ?? "name")"
            priceAmountLabel.text = "\(FormatNumberHelper.formatNumber(price: item.price))"
            categotyAmountLabel.text = "\(item.category ?? "category")"
            
        }
    }
    
    private func setBudgetUsedData() {
        
    }
    func setup() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.purchaseImage)
        self.backView.addSubview(self.purchaseComplete)
        self.backView.addSubview(self.itemName)
        self.backView.addSubview(self.priceLabel)
        self.backView.addSubview(self.priceAmountLabel)
        self.backView.addSubview(self.dueDateLabel)
        self.backView.addSubview(self.dueDateAmountLabel)
        self.backView.addSubview(self.categoryLabel)
        self.backView.addSubview(self.categotyAmountLabel)
        self.backView.addSubview(self.lineView)
        self.backView.addSubview(self.budgetAllocationLabel)
        self.backView.addSubview(self.savingLabel)
        self.backView.addSubview(self.savingAmount)
        self.backView.addSubview(self.doneButton)
    }
    
    func style() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor(named: "BackgroundColor")
        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.backView.backgroundColor = UIColor(named: "PureWhite")
        self.backView.cornerRadius = 15
        NSLayoutConstraint.activate([
            self.backView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.backView.heightAnchor.constraint(equalToConstant: 547)
        ])
        
        self.purchaseImage.image = UIImage(named: "purchase_complete")
        self.purchaseImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.purchaseImage.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 56),
            self.purchaseImage.heightAnchor.constraint(equalToConstant: 121),
            self.purchaseImage.widthAnchor.constraint(equalToConstant: 156),
            self.purchaseImage.centerXAnchor.constraint(equalTo: self.backView.centerXAnchor)
        ])
        
        self.purchaseComplete.text = "Budgets Deducted"
        self.purchaseComplete.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        self.purchaseComplete.textColor = UIColor(named: "StarColor")
        self.purchaseComplete.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.purchaseComplete.topAnchor.constraint(equalTo: self.purchaseImage.bottomAnchor, constant: 13),
            self.purchaseComplete.centerXAnchor.constraint(equalTo: self.backView.centerXAnchor)
//            self.purchaseComplete.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 65),
//            self.purchaseComplete.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -46)
        ])
        
        self.itemName.text = "Keqing 1:7 Scale Figure"
        self.itemName.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.itemName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.itemName.topAnchor.constraint(equalTo: self.purchaseComplete.bottomAnchor, constant: 29),
            self.itemName.centerXAnchor.constraint(equalTo: self.backView.centerXAnchor)
//            self.itemName.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 83),
//            self.itemName.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -67)
        ])
        
        self.priceLabel.text = "Price:"
        self.priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.itemName.bottomAnchor, constant: 39),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 30)
        ])
        
        self.priceAmountLabel.text = "Rp1.700.000"
        self.priceAmountLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.priceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.priceAmountLabel.topAnchor.constraint(equalTo: self.itemName.bottomAnchor, constant: 39),
            self.priceAmountLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        ])
        
        self.dueDateLabel.text = "Due Date:"
        self.dueDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dueDateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 12),
            self.dueDateLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 30)
        ])
        
        self.dueDateAmountLabel.text = "March 3, 2022"
        self.dueDateAmountLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.dueDateAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dueDateAmountLabel.topAnchor.constraint(equalTo: self.priceAmountLabel.bottomAnchor, constant: 12),
            self.dueDateAmountLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        ])
        
        self.categoryLabel.text = "Category:"
        self.categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryLabel.topAnchor.constraint(equalTo: self.dueDateLabel.bottomAnchor, constant: 12),
            self.categoryLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 30)
        ])
        
        self.categotyAmountLabel.text = "Collection Items"
        self.categotyAmountLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.categotyAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categotyAmountLabel.topAnchor.constraint(equalTo: self.dueDateAmountLabel.bottomAnchor, constant: 12),
            self.categotyAmountLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        ])
        
        self.lineView.layer.borderWidth = 1.0
        self.lineView.layer.borderColor = UIColor(named: "OnProgressCellColor")!.cgColor
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.lineView.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 12),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),
            self.lineView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 9),
            self.lineView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -9)
        ])
        
        self.budgetAllocationLabel.text = "Budget Allocation Used:"
        self.budgetAllocationLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.budgetAllocationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.budgetAllocationLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 13),
            self.budgetAllocationLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 20),
            self.budgetAllocationLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -20)
        ])
        
        self.savingLabel.text = "Savings"
        self.savingLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.savingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.savingLabel.topAnchor.constraint(equalTo: self.budgetAllocationLabel.bottomAnchor, constant: 6),
            self.savingLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 30)
        ])
        
        self.savingAmount.text = "Rp1.700.000"
        self.savingAmount.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.savingAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.savingAmount.topAnchor.constraint(equalTo: self.budgetAllocationLabel.bottomAnchor, constant: 6),
            self.savingAmount.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -26)
        ])
        
        self.doneButton.setTitle("Done", for: .normal)
        self.doneButton.backgroundColor = UIColor(named: "PrimaryHSgradient")
        self.doneButton.cornerRadius = 12
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 70),
            self.doneButton.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -70),
            self.doneButton.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -20),
            self.doneButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
