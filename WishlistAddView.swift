//
//  View.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 28/10/21.
//

import Foundation
import UIKit

class WishlistAddView: UITableViewController, UITextViewDelegate, receivedDataDelegate{
    
    // MARK: - Variables
    let tableIdentifier = "DeadlineDatePickerTableViewCell"
    var placeholderLabel: UILabel!
    var category: String = "Technology"
    private let viewModel = WishlistAddViewModel()
    private let purchaseCategoryViewModel = PurchaseCategoryViewModel()
    let dateFormatter = DateFormatter()
    
    
    // MARK: - Outlet

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadlineDatePicker.isHidden = true
        setupUI()
    }
    // MARK: - Actions
    
    @IBAction func dismissPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moveToCategoryPage(_ sender: Any) {
        
        checkEmptyField()
        
        viewModel.items?.name = itemNameTextField.text ?? "None"
        if let price = itemPriceTextField.text {
            viewModel.items?.price  = Int64(price) ?? 0
        }
        viewModel.items?.reason = reasonTextView.text
        viewModel.items?.deadline = deadlineDatePicker.date
        viewModel.items?.category = category
        
        let storyBoard = UIStoryboard(name: "PurchaseSameItem", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "purchaseSameItemPage") as? PurchaseSameItemViewController else {
            fatalError("no view")
        }
        vc.wishlistAdd = viewModel
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Functions
    
    func setupUI() {
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
    
    func checkEmptyField(){
        if itemNameTextField.text!.isEmpty {
            displayAlert(userMessage: "Empty Text Field Name")
            return
        } else if itemPriceTextField.text!.isEmpty {
            displayAlert(userMessage: "Empty Price Field")
            return
        } else if categoryLabel.text == "Collection Items"{
            displayAlert(userMessage: "Choose Category")
            return
        } else if deadlineLabel.text == "Date" {
            displayAlert(userMessage: "Empty Date")
            return
        } else if reasonTextView.text.isEmpty {
            displayAlert(userMessage: "Empty Reason Field")
            return
        }
    }
    
    func displayAlert(userMessage: String){
        let myAlert = UIAlertController(title: "Warning!", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func passData(data: String) {
        categoryLabel.text =  data
        categoryLabel.textColor = UIColor.black
        category = data
    }
    
    // MARK: - TextView Function
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: - PickerView
    @IBAction func dateChanged(_ sender: Any) {
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let date = dateFormatter.string(from: deadlineDatePicker.date)
        deadlineLabel.textColor = UIColor.black
        deadlineLabel.text = date
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
        if indexPath.section == 0 && indexPath.row == 4 {
            let height: CGFloat = deadlineDatePicker.isHidden ? 0.1 : 340.0
            return height
        }

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
//            self.present(vc, animated: true, completion: nil)
            self.present(navVc, animated: true, completion: nil)
        } else if deadlineIndexPath as IndexPath == indexPath {
            deadlineDatePicker.isHidden = !deadlineDatePicker.isHidden

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.tableView.endUpdates()
            })
        }
    }
    
}
