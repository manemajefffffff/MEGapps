//
//  AllocateOtherBudgetView.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import Foundation
import UIKit

class AllocateOtherBudgetView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    // MARK: - Outlet
    @IBOutlet weak var insufficientAmountLabel: UILabel!
    @IBOutlet weak var usedBudgetLabel: UILabel!
    
    @IBOutlet weak var allocateBudgetTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    
    // MARK: - Function
    func register() {
        allocateBudgetTableView.register(UINib(nibName: "AllocateOtherBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "AllocateOtherBudgetTableViewCell")
    }
    
    func addAlert() {
        let alert = UIAlertController(title: "Proceed Wishlist", message: "Are you sure you want to proceed with this wishlist?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {action in
            //move page to purchase overview
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func moveToPurchaseOverview(_ sender: Any) {
        addAlert()
    }
    
    @IBAction func dismissPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func buttonAction(sender: UIButton) {
        print("button tap")
        let storyBoard = UIStoryboard(name: "UseBudgets", bundle: nil)
        let useOtherBudgetVC = storyBoard.instantiateViewController(withIdentifier: "useBudgetsPage")
        self.present(useOtherBudgetVC, animated: true)
    }
    
}

// MARK: - TableView Function
extension AllocateOtherBudgetView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = allocateBudgetTableView.dequeueReusableCell(withIdentifier: "AllocateOtherBudgetTableViewCell") as? AllocateOtherBudgetTableViewCell else {
                fatalError("cell not found!")
            }
            
            return cell
        } else {
            guard let cell = allocateBudgetTableView.dequeueReusableCell(withIdentifier: "useOtherBudgetButton") as? ButtonCellView else {
                fatalError("cell not found!")
            }
            
            cell.useOtherBudgetButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = CGFloat()
        
        if indexPath.section == 0 {
            height = 192
        } else {
            height = 50
        }
        
        return height
    }
}

class ButtonCellView: UITableViewCell {
    @IBOutlet weak var useOtherBudgetButton: UIButton!
}
