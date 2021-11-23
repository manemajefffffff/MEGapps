//
//  PurchaseDetailView.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import UIKit

class PurchaseDetailView: UIView {
    // MARK: - MVVM
    private var viewModel: PurchaseDetailViewModel
    private var viewController: PurchaseDetailViewController

    // MARK: - Outlet
    let navigationBar = UINavigationBar()
    let scrollView = UIScrollView()
    let contentView = UIView()
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
        self.manageData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    func manageData() {
        if let itemName = self.viewModel.item?.name {
            self.itemValueLabel.text = "\(itemName)"
        }
        if let itemPrice = self.viewModel.item?.price {
            self.priceLabel.text = "\(itemPrice)"
            print(itemPrice)
        }
        if let prioritize = self.viewModel.item?.isPrioritize {
            if prioritize == true {
                self.starButton.tintColor = UIColor(named: "StarColor")
            } else {
                self.starButton.tintColor = UIColor(named: "PureWhite")
            }
        }
        if let itemCategory = self.viewModel.item?.category {
            self.categoryValueLabel.text = "\(itemCategory)"
        }
        if let itemReason = self.viewModel.item?.reason {
            self.reasonToBuyValueLabel.text = "\(itemReason)"
        }
        
    }
    
    func setupScrollView() {
        self.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.topAnchor, constant: UIApplication.shared.statusBarFrame.height),
            navigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        let doneButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
        let navigationItem = UINavigationItem(title: "Wishlist Details")
        let image = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
        let cancelbutton = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = cancelbutton
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        doneButton.tintColor = UIColor(named: "PrimaryHSgradient")
        cancelbutton.tintColor = UIColor(named: "PrimaryHSgradient")
        
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
        self.contentView.addSubview(self.dueDateLabel)
        self.contentView.addSubview(self.dueDateValueLabel)
        self.contentView.addSubview(self.categoryLabel)
        self.contentView.addSubview(self.categoryValueLabel)
        self.contentView.addSubview(self.reasonToBuyLabel)
        self.reasonToBuyValueView.addSubview(self.reasonToBuyValueLabel)
        self.contentView.addSubview(self.reasonToBuyValueView)
        self.contentView.addSubview(self.purchaseItemButton)
        self.contentView.addSubview(self.deleteItemButton)
    }
    
    

    func style() {
        self.backgroundColor = UIColor(named: "BackgroundColor")

        self.itemValueLabel.textAlignment = .left
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
        self.priceValueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.itemValueLabel.bottomAnchor, constant: 16),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.priceValueLabel.leadingAnchor, constant: -21),

            self.priceValueLabel.topAnchor.constraint(equalTo: self.itemValueLabel.bottomAnchor, constant: 16),
            self.priceValueLabel.leadingAnchor.constraint(equalTo: self.priceLabel.trailingAnchor, constant: 21),
            self.priceValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21)
        ])

        self.categoryLabel.textAlignment = .left
        self.categoryLabel.text = "Category :"
        self.categoryLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.categoryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryValueLabel.textAlignment = .right
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
            self.reasonToBuyValueView.bottomAnchor.constraint(equalTo: self.purchaseItemButton.topAnchor, constant: -16),
            self.reasonToBuyValueView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.reasonToBuyValueView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21),

            self.reasonToBuyValueLabel.topAnchor.constraint(equalTo: self.reasonToBuyValueView.topAnchor, constant: 0),
            self.reasonToBuyValueLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 0),
            self.reasonToBuyValueLabel.leadingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.reasonToBuyValueLabel.trailingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.trailingAnchor, constant: 0)
        ])

        self.purchaseItemButton.setTitle("Purchase Item", for: .normal)
        self.purchaseItemButton.setTitleColor(UIColor(named: "PureWhite"), for: .normal)
        self.purchaseItemButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.purchaseItemButton.backgroundColor = UIColor(named: "PrimaryHSgradient")
        self.purchaseItemButton.layer.cornerRadius = 10
        self.purchaseItemButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.purchaseItemButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.purchaseItemButton.layer.shadowRadius = 4.0
        self.purchaseItemButton.layer.shadowOpacity = 0.8
        self.purchaseItemButton.addTarget(self, action: #selector(acceptWishlistAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.purchaseItemButton.heightAnchor.constraint(equalToConstant: 49),
            self.purchaseItemButton.topAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 104),
//            self.purchaseItemButton.bottomAnchor.constraint(equalTo: self.deleteItemButton.topAnchor, constant: -12),
            self.purchaseItemButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.purchaseItemButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17)
        ])

        self.deleteItemButton.translatesAutoresizingMaskIntoConstraints = false
        self.deleteItemButton.setTitle("Delete Item", for: .normal)
        self.deleteItemButton.setTitleColor(UIColor(hex: "#000000FF"), for: .normal)
        self.deleteItemButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.deleteItemButton.backgroundColor = UIColor(named: "LightSalmonPink")
        self.deleteItemButton.layer.cornerRadius = 10
        self.deleteItemButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.deleteItemButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.deleteItemButton.layer.shadowRadius = 4.0
        self.deleteItemButton.layer.shadowOpacity = 0.8
        self.purchaseItemButton.addTarget(self, action: #selector(deleteWishlistAction), for: .touchUpInside)
        self.purchaseItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.deleteItemButton.heightAnchor.constraint(equalToConstant: 49),
            self.deleteItemButton.topAnchor.constraint(equalTo: self.purchaseItemButton.bottomAnchor, constant: 16),
//            self.deleteItemButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -128),
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
}
