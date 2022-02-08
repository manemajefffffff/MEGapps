//
//  View.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 28/10/21.
//

import Foundation
import UIKit

protocol sendEditedWishlistBackDelegate: AnyObject {
    func send(_ editedItem: Items)
}

class WishlistAddView: UITableViewController, UITextViewDelegate, receivedDataDelegate {
    
    // MARK: - Variables
    let tableIdentifier = "DeadlineDatePickerTableViewCell"
    var placeholderLabel: UILabel!
    var category: String = "Technology"
    private let viewModel = WishlistAddViewModel()
    private let purchaseCategoryViewModel = PurchaseCategoryViewModel()
    let dateFormatter = DateFormatter()
    
    var oldWishlistData: Items?
    
    // MARK: - Delegate
    weak var delegate: sendEditedWishlistBackDelegate?
    
    
    // MARK: - Outlet

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var reasonTextView: UITextView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.hideKeyboardWhenTappedAround()
    }
    // MARK: - Actions
    
    @IBAction func dismissPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rightBarButtonClicked(_ sender: Any) {
        checkEmptyField()
        
        if oldWishlistData != nil {
            saveEditData()
        } else {
            moveToCategoryPage()
        }
    }
        
    // MARK: - Functions
    
    fileprivate func moveToCategoryPage() {
        viewModel.items?.name = itemNameTextField.text ?? "None"
        if let price = itemPriceTextField.text {
            viewModel.items?.price  = Int64(price) ?? 0
        }
        viewModel.items?.reason = reasonTextView.text
        viewModel.items?.category = category

        let storyBoard = UIStoryboard(name: "PurchaseSameItem", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "purchaseSameItemPage") as? PurchaseSameItemViewController else {
            fatalError("no view")
        }
        vc.wishlistAdd = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func saveEditData() {
        if let oldWishlistData = oldWishlistData {
            oldWishlistData.name = itemNameTextField.text ?? "None"
            if let price = itemPriceTextField.text {
                oldWishlistData.price  = Int64(price) ?? 0
            }
            oldWishlistData.reason = reasonTextView.text
            oldWishlistData.category = category

            viewModel.editOldWishlist(oldWishlistData)
            delegate?.send(oldWishlistData)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func setupUIforEdit() {
        self.navigationItem.rightBarButtonItem?.title = "Save"
        self.title = "Edit Wishlist"
        
        guard let oldWishlistData = oldWishlistData else {
            return
        }

        itemNameTextField.text = "\(oldWishlistData.name ?? "item name")"
        itemPriceTextField.text = "\(oldWishlistData.price)"
        categoryLabel.text = "\(oldWishlistData.category ?? "category")"
        reasonTextView.text = "\(oldWishlistData.reason ?? "reason")"
    }
    
    
    fileprivate func setupUI() {
        if oldWishlistData != nil {
            setupUIforEdit()
        }

        reasonTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Reason to buy"
        placeholderLabel.font = UIFont.systemFont(ofSize: (reasonTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        reasonTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (reasonTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !reasonTextView.text.isEmpty
    }
    
    func checkEmptyField() {
        if itemNameTextField.text!.isEmpty {
            displayAlert(userMessage: "You have not inputted Product Name")
            return
        } else if itemPriceTextField.text!.isEmpty {
            displayAlert(userMessage: "You have not inputted Product Price")
            return
        } else if categoryLabel.text == ""{
            displayAlert(userMessage: "You have not chosen Product Category")
            return
        } else if reasonTextView.text.isEmpty {
            displayAlert(userMessage: "You have not inputted Reason to buy")
            return
        }
    }
    
    func displayAlert(userMessage: String){
        let myAlert = UIAlertController(title: "Error", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func passData(data: String) {
        categoryLabel.text =  data
        categoryLabel.textColor = UIColor.gray
        category = data
        self.tableView.reloadData()
    }
    
    // MARK: - TextView Function
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: - TableView Function
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let shadowView = UIView()
        
        let containerview = CALayer()
        containerview.frame.size = CGSize(width: tableView.bounds.width - 40, height: 15)
        
        containerview.backgroundColor = UIColor.clear.cgColor
        containerview.shadowColor = UIColor.lightGray.cgColor
        containerview.shadowOffset = CGSize(width: 0, height: 5)
        containerview.shadowOpacity = 0.5
        containerview.shadowRadius = 2
        
        shadowView.layer.addSublayer(containerview)
        
        return shadowView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deadlineIndexPath = NSIndexPath(row: 3, section: 0)
        let categoryIndexPath = NSIndexPath(row: 2, section: 0)

        if categoryIndexPath as IndexPath == indexPath {
            let storyBoard = UIStoryboard(name: "PurchaseCategory", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "purchaseViewController") as? PurchaseCategoryView else {
                fatalError("no view")
            }
            let navVc = UINavigationController(rootViewController: vc)
            
            vc.delegate = self
            vc.modalPresentationStyle = .pageSheet
            self.present(navVc, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
