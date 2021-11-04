//
//  View.swift
//  MEGapps
//
//  Created by Aldo Febrian on 27/10/21.
//

import Foundation
import UIKit

class WishlistDetailView: UIView {
    // MARK: - MVVM
    private var viewModel: WishlistDetailViewModel
    private var viewController: WishlistDetailViewController

    // MARK: - Outlet
    private let itemValueLabel = UILabel()
    private let priceLabel = UILabel()
    private let priceValueLabel = UILabel()
    private let dueDateLabel = UILabel()
    private let dueDateValueLabel = UILabel()
    private let categoryLabel = UILabel()
    private let categoryValueLabel = UILabel()
    private let reasonToBuyLabel = UILabel()
    private let reasonToBuyValueLabel = PaddingLabel()
    private let reasonToBuyValueView = UIView()
    private let statementValueLabel = UILabel()
    private let acceptWishlistButton = UIButton()
    private let deleteWishlistButton = UIButton()

    // MARK: - Lifecycle
    init(viewModel: WishlistDetailViewModel, viewController: WishlistDetailViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)

        self.setup()
        self.style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    func setup() {
        self.addSubview(self.itemValueLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.priceValueLabel)
        self.addSubview(self.dueDateLabel)
        self.addSubview(self.dueDateValueLabel)
        self.addSubview(self.categoryLabel)
        self.addSubview(self.categoryValueLabel)
        self.addSubview(self.reasonToBuyLabel)
        self.reasonToBuyValueView.addSubview(self.reasonToBuyValueLabel)
        self.addSubview(self.reasonToBuyValueView)
        self.addSubview(self.statementValueLabel)
        self.addSubview(self.acceptWishlistButton)
        self.addSubview(self.deleteWishlistButton)
    }

    func style() {
        self.backgroundColor = UIColor(named: "BabyPowder")
        self.styleItem()
        self.stylePrice()
        self.styleDueDate()
        self.styleCategory()
        self.styleReasonToBuy()
        self.styleStatement()
        self.styleAcceptWishlistButton()
        self.styleDeleteWishlistButton()
    }

    func styleItem() {
        self.itemValueLabel.textAlignment = .left
        self.itemValueLabel.text = "Macbook Pro 2021"
        self.itemValueLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.itemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.itemValueLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.itemValueLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16)
        ])
    }

    func stylePrice() {
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
            self.priceLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.priceValueLabel.topAnchor.constraint(equalTo: self.itemValueLabel.bottomAnchor, constant: 16),
            self.priceValueLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
    }

    func styleDueDate() {
        self.dueDateLabel.textAlignment = .left
        self.dueDateLabel.text = "Due Date :"
        self.dueDateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.dueDateValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dueDateValueLabel.textAlignment = .right
        self.dueDateValueLabel.text = "31 January 2022"
        self.dueDateValueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dueDateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 16),
            self.dueDateLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.dueDateValueLabel.topAnchor.constraint(equalTo: self.priceValueLabel.bottomAnchor, constant: 16),
            self.dueDateValueLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
    }

    func styleCategory() {
        self.categoryLabel.textAlignment = .left
        self.categoryLabel.text = "Category :"
        self.categoryLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.categoryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryValueLabel.textAlignment = .right
        self.categoryValueLabel.text = "Technology"
        self.categoryValueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryLabel.topAnchor.constraint(equalTo: self.dueDateLabel.bottomAnchor, constant: 16),
            self.categoryLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.categoryValueLabel.topAnchor.constraint(equalTo: self.dueDateValueLabel.bottomAnchor, constant: 16),
            self.categoryValueLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
    }

    func styleReasonToBuy() {
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
            self.reasonToBuyLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.reasonToBuyValueView.heightAnchor.constraint(equalTo: self.reasonToBuyValueLabel.heightAnchor),
            self.reasonToBuyValueView.topAnchor.constraint(equalTo: self.reasonToBuyLabel.bottomAnchor, constant: 16),
            self.reasonToBuyValueView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.reasonToBuyValueView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16),
            self.reasonToBuyValueLabel.topAnchor.constraint(equalTo: self.reasonToBuyValueView.topAnchor, constant: 0),
            self.reasonToBuyValueLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 0),
            self.reasonToBuyValueLabel.leadingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.reasonToBuyValueLabel.trailingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.trailingAnchor, constant: 0)
        ])
    }

    func styleStatement() {
        self.statementValueLabel.textAlignment = NSTextAlignment.left
        self.statementValueLabel.text = "You are going to buy a Macbook Pro 2021 at the price of Rp. 99.000.000, in the category of Technologies with the reason of Increasing Social Status.\n\n"
        self.statementValueLabel.font = .systemFont(ofSize: 15, weight: .regular)
        self.statementValueLabel.numberOfLines = 0
        self.statementValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.statementValueLabel.topAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 16),
            self.statementValueLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 26),
            self.statementValueLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -26)
        ])
    }
    
    func styleAcceptWishlistButton() {
        self.acceptWishlistButton.setTitle("Accept Wishlist", for: .normal)
        self.acceptWishlistButton.setTitleColor(UIColor(hex: "#000000FF"), for: .normal)
        self.acceptWishlistButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.acceptWishlistButton.backgroundColor = UIColor(hex: "#BCDF86FF")
        self.acceptWishlistButton.layer.cornerRadius = 10
        self.acceptWishlistButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.acceptWishlistButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.acceptWishlistButton.layer.shadowRadius = 4.0
        self.acceptWishlistButton.layer.shadowOpacity = 0.8
        self.acceptWishlistButton.addTarget(self, action: #selector(acceptWishlistAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.acceptWishlistButton.heightAnchor.constraint(equalToConstant: 49),
            self.acceptWishlistButton.topAnchor.constraint(equalTo: self.statementValueLabel.bottomAnchor, constant: 77),
            self.acceptWishlistButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.acceptWishlistButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
    }

    func styleDeleteWishlistButton() {
        self.deleteWishlistButton.translatesAutoresizingMaskIntoConstraints = false
        self.deleteWishlistButton.setTitle("Delete Wishlist", for: .normal)
        self.deleteWishlistButton.setTitleColor(UIColor(hex: "#000000FF"), for: .normal)
        self.deleteWishlistButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.deleteWishlistButton.backgroundColor = UIColor(hex: "#F59A9AFF")
        self.deleteWishlistButton.layer.cornerRadius = 10
        self.deleteWishlistButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.deleteWishlistButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.deleteWishlistButton.layer.shadowRadius = 4.0
        self.deleteWishlistButton.layer.shadowOpacity = 0.8
        self.acceptWishlistButton.addTarget(self, action: #selector(deleteWishlistAction), for: .touchUpInside)
        self.acceptWishlistButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.deleteWishlistButton.heightAnchor.constraint(equalToConstant: 49),
            self.deleteWishlistButton.topAnchor.constraint(equalTo: self.acceptWishlistButton.bottomAnchor, constant: 12),
            self.deleteWishlistButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            self.deleteWishlistButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
    }

    @objc func acceptWishlistAction() {
        self.viewController.showAcceptAlert()
    }

    @objc func deleteWishlistAction() {
        self.viewController.showDeleteAlert()
    }
}
