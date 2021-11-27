//
//  PurchaseDetailView.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import UIKit
import Combine

class PurchaseDetailView: UIView {
    // MARK: - MVVM
    private var viewModel: PurchaseDetailViewModel
    private var viewController: PurchaseDetailViewController
    
    // MARK: - Combine
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Outlet
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private let yourBudgetLabel = UILabel()
    
    let yourBudgetView = UIView()
    private let yourSavingAmountLabel = PaddingLabel()
    private let yourSavingAmountValueLabel = PaddingLabel()
    private let insufficientAmountLabel = PaddingLabel()
    private let insufficientAmountValueLabel = PaddingLabel()
    private let savingsAmountLeftLabel = PaddingLabel()
    private let savingsAmountLeftValueLabel = PaddingLabel()
    private let savingsUsedLabel = PaddingLabel()
    private let savingsUsedValueLabel = PaddingLabel()
    
    private let itemValueLabel = UILabel()
    private let starButton = UIButton()
    private let priceLabel = UILabel()
    private let priceValueLabel = UILabel()
    private let dueDateLabel = UILabel()
    private let dueDateValueLabel = UILabel()
    private let categoryLabel = UILabel()
    private let categoryValueLabel = UILabel()
    private let reasonToBuyLabel = UILabel()
    private let reasonToBuyValueLabel = PaddingLabel()
    private let reasonToBuyValueView = UIView()
    private let purchaseItemButton = UIButton()
    private let deleteItemButton = UIButton()
    
    // MARK: - Lifecycle
    init(viewModel: PurchaseDetailViewModel, viewController: PurchaseDetailViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)
        
        self.setupScrollView()
        self.setup()
        self.style()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func subscribe() {
        self.viewModel.$item
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.setData()
            }.store(in: &anyCancellable)
        
        self.viewModel.$isSufficient
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.sufficientStat()
            }.store(in: &anyCancellable)
        
        self.viewModel.$insufficientAmt
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.sufficientStat()
            }.store(in: &anyCancellable)
        
        self.viewModel.$savingsLeft
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.setSavingLefAmt()
            }.store(in: &anyCancellable)
    }
    
    func sufficientStat() {
        
    }
    
    func setInsufficientAmt() {
        
    }
    
    func setSavingLefAmt() {
        
    }
    
    func setData() {
        if let itemName = self.viewModel.item?.name {
            self.itemValueLabel.text = itemName
        }
        
        if let itemPrice = self.viewModel.item?.price {
            self.priceValueLabel.text = formatNumber(price: itemPrice)
        }
        
        if let itemCategory = self.viewModel.item?.category {
            self.categoryValueLabel.text = itemCategory
        }
        
        if let itemReason = self.viewModel.item?.reason {
            self.reasonToBuyValueLabel.text = itemReason
        }
        
        self.yourSavingAmountValueLabel.text = "\(formatNumber(price: (self.viewModel.savingsTotal)))"
        
        if let savingsUsed = self.viewModel.item?.price {
            self.savingsUsedValueLabel.text = formatNumber(price: savingsUsed)
        }
        
        self.savingsAmountLeftValueLabel.text = "\(formatNumber(price: (self.viewModel.savingsLeft)))"
        
        self.insufficientAmountValueLabel.text = "\(formatNumber(price: (self.viewModel.insufficientAmt)))"
    }
    
    func formatNumber(price: Int64) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let formattedPrice = formatter.string(from: price as NSNumber) {
            return "Rp. \(formattedPrice)"
        }
        return "Rp. 0"
    }
    
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
        self.contentView.addSubview(self.itemValueLabel)
        self.contentView.addSubview(self.starButton)
        self.contentView.addSubview(self.priceLabel)
        self.contentView.addSubview(self.priceValueLabel)
        self.contentView.addSubview(self.categoryLabel)
        self.contentView.addSubview(self.categoryValueLabel)
        self.contentView.addSubview(self.reasonToBuyLabel)
        self.reasonToBuyValueView.addSubview(self.reasonToBuyValueLabel)
        self.contentView.addSubview(self.reasonToBuyValueView)
        
        // MARK: - Your Budget Setup
        self.contentView.addSubview(self.yourBudgetLabel)
        self.contentView.addSubview(self.yourBudgetView)
        self.yourBudgetView.addSubview(self.yourSavingAmountLabel)
        self.yourBudgetView.addSubview(self.yourSavingAmountValueLabel)
        self.yourBudgetView.addSubview(self.insufficientAmountLabel)
        self.yourBudgetView.addSubview(self.insufficientAmountValueLabel)
        
        self.yourBudgetView.addSubview(self.savingsUsedLabel)
        self.yourBudgetView.addSubview(self.savingsUsedValueLabel)
        self.yourBudgetView.addSubview(self.savingsAmountLeftLabel)
        self.yourBudgetView.addSubview(self.savingsAmountLeftValueLabel)
        
        if viewModel.isSufficient == true {
            insufficientAmountLabel.isHidden = true
            insufficientAmountValueLabel.isHidden = true
        } else {
            savingsUsedLabel.isHidden = true
            savingsUsedValueLabel.isHidden = true
            savingsAmountLeftLabel.isHidden = true
            savingsAmountLeftValueLabel.isHidden = true
        }
        
        // MARK: - Buttons Setup
        self.scrollView.addSubview(self.purchaseItemButton)
        self.scrollView.addSubview(self.deleteItemButton)
        
        // MARK: - Navigation Bar Setup
        self.viewController.navigationItem.largeTitleDisplayMode = .never
        self.viewController.title =  "Accepted Wishlist"
        
        let image = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
        let cancelbutton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(dismissPage(sender:)))
        self.viewController.navigationItem.leftBarButtonItem = cancelbutton
        cancelbutton.tintColor = UIColor(named: "PrimaryHSgradient")
        
    }
    
    func style() {
        self.backgroundColor = UIColor(named: "BackgroundColor")
        
        self.itemValueLabel.textAlignment = .left
        self.itemValueLabel.text = "Macbook Pro 2021"
        self.itemValueLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.itemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.itemValueLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.itemValueLabel.bottomAnchor.constraint(equalTo: self.priceLabel.topAnchor, constant: -16),
            self.itemValueLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.itemValueLabel.trailingAnchor.constraint(equalTo: self.starButton.trailingAnchor, constant: -21)
        ])
        
        self.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.starButton.translatesAutoresizingMaskIntoConstraints = false
        self.starButton.tintColor = UIColor(named: "StarColor")
        NSLayoutConstraint.activate([
            self.starButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.starButton.bottomAnchor.constraint(equalTo: self.priceLabel.topAnchor, constant: -16),
            self.starButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21)
        ])
        
        self.priceLabel.textAlignment = .left
        self.priceLabel.text = "Price :"
        self.priceLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.priceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceValueLabel.textAlignment = .right
        self.priceValueLabel.text = "Rp999.999,00"
        self.priceValueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.itemValueLabel.bottomAnchor, constant: 16),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.categoryLabel.topAnchor, constant: -16),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.priceValueLabel.leadingAnchor, constant: -21),
            
            self.priceValueLabel.topAnchor.constraint(equalTo: self.itemValueLabel.bottomAnchor, constant: 16),
            self.priceValueLabel.bottomAnchor.constraint(equalTo: self.categoryValueLabel.topAnchor, constant: -16),
            self.priceValueLabel.leadingAnchor.constraint(equalTo: self.priceLabel.trailingAnchor, constant: 21),
            self.priceValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21)
        ])
        
        self.categoryLabel.textAlignment = .left
        self.categoryLabel.text = "Category :"
        self.categoryLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.categoryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryValueLabel.textAlignment = .right
        self.categoryValueLabel.text = "Technology"
        self.categoryValueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 16),
            self.categoryLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyLabel.topAnchor, constant: -16),
            self.categoryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.categoryLabel.trailingAnchor.constraint(equalTo: self.categoryValueLabel.leadingAnchor, constant: -21),
            
            self.categoryValueLabel.topAnchor.constraint(equalTo: self.priceValueLabel.bottomAnchor, constant: 16),
            self.categoryValueLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyLabel.topAnchor, constant: -16),
            self.categoryValueLabel.leadingAnchor.constraint(equalTo: self.categoryLabel.trailingAnchor, constant: 21),
            self.categoryValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21)
        ])
        
        self.reasonToBuyLabel.textAlignment = .left
        self.reasonToBuyLabel.text = "Reason To Buy :"
        self.reasonToBuyLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.reasonToBuyValueView.translatesAutoresizingMaskIntoConstraints = false
        self.reasonToBuyValueView.backgroundColor = UIColor(hex: "#FFFFFFFF")
        self.reasonToBuyValueView.layer.cornerRadius = 5
        self.reasonToBuyValueView.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.reasonToBuyValueView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.reasonToBuyValueView.layer.shadowRadius = 4.0
        self.reasonToBuyValueView.layer.shadowOpacity = 0.8
        
        self.reasonToBuyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.reasonToBuyValueLabel.textAlignment = NSTextAlignment.left
        self.reasonToBuyValueLabel.text = "Increasing Social Status\n"
        self.reasonToBuyValueLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.reasonToBuyValueLabel.numberOfLines = 0
        self.reasonToBuyValueLabel.padding(10, 10, 10, 10)
        self.reasonToBuyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.reasonToBuyLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 16),
            self.reasonToBuyLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyValueView.topAnchor, constant: -16),
            self.reasonToBuyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.reasonToBuyLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21),
            
            self.reasonToBuyValueView.heightAnchor.constraint(equalTo: self.reasonToBuyValueLabel.heightAnchor),
            self.reasonToBuyValueView.topAnchor.constraint(equalTo: self.reasonToBuyLabel.bottomAnchor, constant: 16),
            self.reasonToBuyValueView.bottomAnchor.constraint(equalTo: self.yourBudgetLabel.topAnchor, constant: -16),
            self.reasonToBuyValueView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.reasonToBuyValueView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21),
            
            self.reasonToBuyValueLabel.topAnchor.constraint(equalTo: self.reasonToBuyValueView.topAnchor, constant: 0),
            self.reasonToBuyValueLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 0),
            self.reasonToBuyValueLabel.leadingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.reasonToBuyValueLabel.trailingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.trailingAnchor, constant: 0)
        ])
        
        // Your Budget Label
        self.yourBudgetLabel.textAlignment = .left
        self.yourBudgetLabel.text = "Your Budgets"
        self.yourBudgetLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.yourBudgetLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            self.yourBudgetLabel.topAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 30),
            self.yourBudgetLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        // Your Budget View
        self.yourBudgetView.backgroundColor = UIColor(named: "PureWhite")
        self.yourBudgetView.layer.cornerRadius = 15
        self.yourBudgetView.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.yourBudgetView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.yourBudgetView.layer.shadowRadius = 4.0
        self.yourBudgetView.layer.shadowOpacity = 0.8
        self.yourBudgetView.translatesAutoresizingMaskIntoConstraints = false
        self.yourBudgetView.frame.size.height = yourSavingAmountLabel.frame.size.height + insufficientAmountLabel.frame.size.height
        // savingsUsedLabel.frame.size.height + savingsAmountLeftLabel.frame.size.height
        
        // NEED FIX auto layout your budget height
        NSLayoutConstraint.activate([
            self.yourBudgetView.topAnchor.constraint(equalTo: self.yourBudgetLabel.bottomAnchor, constant: 16),
            self.yourBudgetView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.yourBudgetView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.yourBudgetView.bottomAnchor.constraint(equalTo: self.purchaseItemButton.topAnchor, constant: -142)
        ])
        
        // Your Saving Amount Label
        self.yourSavingAmountLabel.text = "Your Savings Amount"
        self.yourSavingAmountLabel.textAlignment = NSTextAlignment.left
        self.yourSavingAmountLabel.font =  .systemFont(ofSize: 13, weight: .medium)
        self.yourSavingAmountLabel.numberOfLines = 0
        self.yourSavingAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.yourSavingAmountLabel.topAnchor.constraint(equalTo: self.yourBudgetView.topAnchor, constant: 20),
            self.yourSavingAmountLabel.leadingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.leadingAnchor, constant: 18)
        ])
        
        // Your Budget Amount Value Label
        self.yourSavingAmountValueLabel.text = "Rp. 2.000.000"
        self.yourSavingAmountValueLabel.textAlignment = NSTextAlignment.left
        self.yourSavingAmountValueLabel.font =  .systemFont(ofSize: 17, weight: .semibold)
        self.yourSavingAmountValueLabel.numberOfLines = 0
        self.yourSavingAmountValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.yourSavingAmountValueLabel.topAnchor.constraint(equalTo: self.yourBudgetView.topAnchor, constant: 20),
            self.yourSavingAmountValueLabel.trailingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.trailingAnchor, constant: -18)
        ])
        
        self.insufficientAmountLabel.text = "Insufficient Amount"
        self.insufficientAmountLabel.textAlignment = NSTextAlignment.left
        self.insufficientAmountLabel.font =  .systemFont(ofSize: 13, weight: .medium)
        self.insufficientAmountLabel.numberOfLines = 0
        self.insufficientAmountLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.insufficientAmountLabel.topAnchor.constraint(equalTo: self.yourSavingAmountLabel.bottomAnchor, constant: 20),
                self.insufficientAmountLabel.leadingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.leadingAnchor, constant: 18)
            ])
                
        // Insufficient Amount Value Label
        self.insufficientAmountValueLabel.text = "Rp. 2.000.000"
        self.insufficientAmountValueLabel.textAlignment = NSTextAlignment.left
        self.insufficientAmountValueLabel.font =  .systemFont(ofSize: 17, weight: .semibold)
        self.insufficientAmountValueLabel.numberOfLines = 0
        self.insufficientAmountValueLabel.textColor = .red
        self.insufficientAmountValueLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.insufficientAmountValueLabel.topAnchor.constraint(equalTo: self.yourSavingAmountLabel.bottomAnchor, constant: 20),
                self.insufficientAmountValueLabel.trailingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.trailingAnchor, constant:-18)
                ])
                
        self.savingsUsedLabel.text = "Savings Used"
        self.savingsUsedLabel.textAlignment = NSTextAlignment.left
        self.savingsUsedLabel.font =  .systemFont(ofSize: 13, weight: .medium)
        self.savingsUsedLabel.numberOfLines = 0
        self.savingsUsedLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.savingsUsedLabel.topAnchor.constraint(equalTo: self.yourSavingAmountLabel.bottomAnchor, constant: 20),
                self.savingsUsedLabel.leadingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.leadingAnchor, constant: 18)
            ])
            
        self.savingsUsedValueLabel.text = "Rp. 2.000.000"
        self.savingsUsedValueLabel.textAlignment = NSTextAlignment.left
        self.savingsUsedValueLabel.font =  .systemFont(ofSize: 17, weight: .semibold)
        self.savingsUsedValueLabel.numberOfLines = 0
        self.savingsUsedValueLabel.textColor = .red
        self.savingsUsedValueLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.savingsUsedValueLabel.topAnchor.constraint(equalTo: self.yourSavingAmountLabel.bottomAnchor, constant: 20),
                self.savingsUsedValueLabel.trailingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.trailingAnchor, constant: -18)
            ])
    
            // Tambahkan if untuk munculin savings amount left
        self.savingsAmountLeftLabel.text = "Savings Amount Left"
        self.savingsAmountLeftLabel.textAlignment = NSTextAlignment.left
        self.savingsAmountLeftLabel.font =  .systemFont(ofSize: 13, weight: .medium)
        self.savingsAmountLeftLabel.numberOfLines = 0
        self.savingsAmountLeftLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.savingsAmountLeftLabel.topAnchor.constraint(equalTo: self.savingsUsedLabel.bottomAnchor, constant: 20),
                self.savingsAmountLeftLabel.leadingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.leadingAnchor, constant: 18)
            ])
            
            // Insufficient Amount Value Label
        self.savingsAmountLeftValueLabel.text = "Rp. 2.000.000"
        self.savingsAmountLeftValueLabel.textAlignment = NSTextAlignment.left
        self.savingsAmountLeftValueLabel.font =  .systemFont(ofSize: 17, weight: .semibold)
        self.savingsAmountLeftValueLabel.numberOfLines = 0
        self.savingsAmountLeftValueLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.savingsAmountLeftValueLabel.topAnchor.constraint(equalTo: self.savingsUsedLabel.bottomAnchor, constant: 20),
                self.savingsAmountLeftValueLabel.trailingAnchor.constraint(equalTo: self.yourBudgetView.layoutMarginsGuide.trailingAnchor, constant: -18)
            ])
        if viewModel.isSufficient == true {
            self.purchaseItemButton.setTitle("Proceed Wishlist", for: .normal)
        } else {
            self.purchaseItemButton.setTitle("Allocate Other Budget", for: .normal)
        }
        self.purchaseItemButton.setTitleColor(UIColor(named: "PureWhite"), for: .normal)
        self.purchaseItemButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.purchaseItemButton.backgroundColor = UIColor(named: "PrimaryHSgradient")
        self.purchaseItemButton.layer.cornerRadius = 10
        self.purchaseItemButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.purchaseItemButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.purchaseItemButton.layer.shadowRadius = 4.0
        self.purchaseItemButton.layer.shadowOpacity = 0.8
        self.purchaseItemButton.addTarget(self, action: #selector(acceptWishlistAction), for: .touchUpInside)
        self.purchaseItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.purchaseItemButton.heightAnchor.constraint(equalToConstant: 49),
            self.purchaseItemButton.bottomAnchor.constraint(equalTo: self.deleteItemButton.topAnchor, constant: -12),
            self.purchaseItemButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.purchaseItemButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17)
        ])
        
        self.deleteItemButton.setTitle("Delete Wishlist", for: .normal)
        self.deleteItemButton.setTitleColor(UIColor(hex: "#000000FF"), for: .normal)
        self.deleteItemButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.deleteItemButton.backgroundColor = UIColor(named: "LightSalmonPink")
        self.deleteItemButton.layer.cornerRadius = 10
        self.deleteItemButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.deleteItemButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.deleteItemButton.layer.shadowRadius = 4.0
        self.deleteItemButton.layer.shadowOpacity = 0.8
        
        self.deleteItemButton.addTarget(self, action: #selector(deleteWishlistAction), for: .touchUpInside)
        self.deleteItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.deleteItemButton.heightAnchor.constraint(equalToConstant: 49),
            self.deleteItemButton.topAnchor.constraint(equalTo: self.purchaseItemButton.bottomAnchor, constant: 12),
            self.deleteItemButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 650),
            self.deleteItemButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.deleteItemButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17)
        ])
    }
    
    @objc func acceptWishlistAction() {
        self.viewController.showAcceptAlert()
    }
    
    @objc func deleteWishlistAction() {
        self.viewController.showDeleteAlert()
    }
    
    @objc func dismissPage(sender: UIBarButtonItem) {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
