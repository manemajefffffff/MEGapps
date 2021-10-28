//
//  View.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 28/10/21.
//

import Foundation
import UIKit

class PurchaseAddView: UITableViewController {
    
    // MARK: - Variables
    let tableIdentifier = "DeadlineDatePickerTableViewCell"
    
    // MARK: - Outlet

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!

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
    // MARK: - Functions
    
    func setupUI() {

        
    }
    
    // MARK: - TableView Function
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
