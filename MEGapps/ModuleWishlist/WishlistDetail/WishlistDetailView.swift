//
//  View.swift
//  MEGapps
//
//  Created by Aldo Febrian on 27/10/21.
//

import Foundation
import UIKit
import Combine

class WishlistDetailView: UIView {
    // MARK: - Combine
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - MVVM
    private var viewModel: WishlistDetailViewModel
    private var viewController: WishlistDetailViewController

    // MARK: - Outlet
    let scrollView = UIScrollView()
    let contentView = UIView()
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
    private let acceptWishlistButton = UIButton()
    private let deleteWishlistButton = UIButton()

    // MARK: - Lifecycle
    init(viewModel: WishlistDetailViewModel, viewController: WishlistDetailViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: .zero)

        self.setupScrollView()
        self.setup()
        self.style()
        subscribeViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    func subscribeViewModel() {
        self.viewModel.$wishlist
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.setData()
                self.checkReadyOrWait()
            }.store(in: &anyCancellable)
    }
    
    func setData() {
        if let name = self.viewModel.wishlist.name {
            self.itemValueLabel.text = "\(name)"
        }
        
        self.priceValueLabel.text = formatNumber(price: self.viewModel.wishlist.price)
        
        if let dueDate = self.viewModel.wishlist.deadline {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            self.dueDateValueLabel.text = "\(dateFormatter.string(from: dueDate))"
        }
        
        if let category = self.viewModel.wishlist.category {
            self.categoryValueLabel.text = "\(category)"
        }
        
        if let reason = self.viewModel.wishlist.reason {
            self.reasonToBuyValueLabel.text = "\(reason)"
        }
    }
    
    func checkReadyOrWait() {
        if let date = self.viewModel.wishlist.createdAt {
            if let addedDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                if addedDate > Date() {
                    acceptWishlistButton.isHidden = true
                }
            }
        }
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
        self.contentView.addSubview(self.priceLabel)
        self.contentView.addSubview(self.priceValueLabel)
        self.contentView.addSubview(self.dueDateLabel)
        self.contentView.addSubview(self.dueDateValueLabel)
        self.contentView.addSubview(self.categoryLabel)
        self.contentView.addSubview(self.categoryValueLabel)
        self.contentView.addSubview(self.reasonToBuyLabel)
        self.reasonToBuyValueView.addSubview(self.reasonToBuyValueLabel)
        self.contentView.addSubview(self.reasonToBuyValueView)
    
        self.scrollView.addSubview(self.acceptWishlistButton)
    
        self.scrollView.addSubview(self.deleteWishlistButton)
        
        self.viewController.navigationItem.largeTitleDisplayMode = .never
        self.viewController.title = "Wishlist Detail"
        self.viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(moveToEditPage))
        self.viewController.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "PrimaryHSgradient")
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
            self.itemValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21)
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
            self.dueDateLabel.bottomAnchor.constraint(equalTo: self.categoryLabel.topAnchor, constant: -16),
            self.dueDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.dueDateLabel.trailingAnchor.constraint(equalTo: self.dueDateValueLabel.leadingAnchor, constant: -21),

            self.dueDateValueLabel.topAnchor.constraint(equalTo: self.priceValueLabel.bottomAnchor, constant: 16),
            self.dueDateValueLabel.bottomAnchor.constraint(equalTo: self.categoryValueLabel.topAnchor, constant: -16),
            self.dueDateValueLabel.leadingAnchor.constraint(equalTo: self.dueDateLabel.trailingAnchor, constant: 21),
            self.dueDateValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21)
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
//            self.reasonToBuyValueView.bottomAnchor.constraint(equalTo: self.acceptWishlistButton.topAnchor, constant: -16),
            self.reasonToBuyValueView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 21),
            self.reasonToBuyValueView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -21),

            self.reasonToBuyValueLabel.topAnchor.constraint(equalTo: self.reasonToBuyValueView.topAnchor, constant: 0),
            self.reasonToBuyValueLabel.bottomAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 0),
            self.reasonToBuyValueLabel.leadingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.reasonToBuyValueLabel.trailingAnchor.constraint(equalTo: self.reasonToBuyValueView.layoutMarginsGuide.trailingAnchor, constant: 0)
        ])
        
        //Button

        self.acceptWishlistButton.setTitle("Accept Wishlist", for: .normal)
        self.acceptWishlistButton.setTitleColor(UIColor(named: "PureWhite"), for: .normal)
        self.acceptWishlistButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.acceptWishlistButton.backgroundColor = UIColor(named: "PrimaryHSgradient")
        self.acceptWishlistButton.layer.cornerRadius = 10
        self.acceptWishlistButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.acceptWishlistButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.acceptWishlistButton.layer.shadowRadius = 4.0
        self.acceptWishlistButton.layer.shadowOpacity = 0.8
        self.acceptWishlistButton.addTarget(self, action: #selector(acceptWishlistAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.acceptWishlistButton.heightAnchor.constraint(equalToConstant: 49),
//            // self.acceptWishlistButton.topAnchor.constraint(equalTo: self.reasonToBuyValueView.bottomAnchor, constant: 77),
            self.acceptWishlistButton.bottomAnchor.constraint(equalTo: self.deleteWishlistButton.topAnchor, constant: -12),
            self.acceptWishlistButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.acceptWishlistButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17)
        ])

        self.deleteWishlistButton.translatesAutoresizingMaskIntoConstraints = false
        self.deleteWishlistButton.setTitle("Cancel Wishlist", for: .normal)
        self.deleteWishlistButton.setTitleColor(UIColor(hex: "#000000FF"), for: .normal)
        self.deleteWishlistButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.deleteWishlistButton.backgroundColor = UIColor(named: "LightSalmonPink")
        self.deleteWishlistButton.layer.cornerRadius = 10
        self.deleteWishlistButton.layer.shadowColor = UIColor(hex: "#BBBBBBFF")?.cgColor
        self.deleteWishlistButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.deleteWishlistButton.layer.shadowRadius = 4.0
        self.deleteWishlistButton.layer.shadowOpacity = 0.8
        self.deleteWishlistButton.addTarget(self, action: #selector(deleteWishlistAction), for: .touchUpInside)
        self.acceptWishlistButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.deleteWishlistButton.heightAnchor.constraint(equalToConstant: 49),
            self.deleteWishlistButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 650),
            self.deleteWishlistButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            self.deleteWishlistButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -17)
        ])
    }

    @objc func acceptWishlistAction() {
        
        self.viewController.showAcceptAlert()
    }

    @objc func deleteWishlistAction() {
        self.viewController.showDeleteAlert()
    }
    
    @objc func moveToEditPage() {
        self.viewController.showEditPage()
    }
    
    @objc func dismissPage(sender: UIBarButtonItem) {
        self.viewController.navigationController?.popViewController(animated: true)
    }
}
