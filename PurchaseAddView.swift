//
//  View.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 28/10/21.
//

import Foundation
import UIKit

class PurchaseAddView: UITableViewController, UITextViewDelegate {
    
    // MARK: - Variables
    let tableIdentifier = "DeadlineDatePickerTableViewCell"
    var placeholderLabel: UILabel!
    
    // MARK: - Outlet

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var reasonTextView: UITextView!
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadlineDatePicker.isHidden = true
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction func dismissPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveToCategoryPage(_ sender: Any) {
        
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
    
    // MARK: - TextView Function
    func textViewDidChange(_ textView: UITextView) {
            placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: - TableView Function
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
//        let shadowView = UIView()
//
//        let gradient = CAGradientLayer()
//        gradient.frame.size = CGSize(width: tableView.bounds.width - 40, height: 15)
//
//        let stopColor = UIColor.gray.cgColor
//        let startColor = UIColor.white.cgColor
//
//        gradient.colors = [stopColor, startColor]
//        gradient.locations = [0.0, 0.8]
//        gradient.opacity = 0.5
//
//        shadowView.layer.addSublayer(gradient)
//
//        return shadowView
        
        let shadowView = UIView()
        
        //let containerView: UIView = UIView(frame: self.tableView.frame)
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

        if deadlineIndexPath as IndexPath == indexPath {
            deadlineDatePicker.isHidden = !deadlineDatePicker.isHidden

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.tableView.endUpdates()
            })
        }
    }
    
}
