//
//  OtherBudgetViewController.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 02/11/21.
//

import Foundation
import UIKit

class OtherBudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlet
    
    @IBOutlet weak var budgetTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        
    }
    
    
    // MARK: - Actions
    @IBAction func moveToAddBudget(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "AddEditBudget", bundle: nil)
        let addOtherBudgetVC = storyBoard.instantiateViewController(withIdentifier: "addOtherBudget")
        
        //Half Sheet
        if let presentationController = addOtherBudgetVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(addOtherBudgetVC, animated: true)
    }
    
    // MARK: - Functions
    func register() {
        budgetTableView.register(UINib(nibName: "OtherBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherBudgetTableViewCell")
    }
}

extension OtherBudgetViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = budgetTableView.dequeueReusableCell(withIdentifier: "OtherBudgetTableViewCell") as? OtherBudgetTableViewCell else {
            fatalError("cell not found!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "AddEditBudget", bundle: nil)
        let destination = storyBoard.instantiateViewController(withIdentifier: "addOtherBudget")
        
        if let presentationController = destination.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(destination, animated: true)
    }
    
}

