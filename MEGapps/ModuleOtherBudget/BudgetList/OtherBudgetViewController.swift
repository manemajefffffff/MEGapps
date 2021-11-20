//
//  OtherBudgetViewController.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 02/11/21.
//

import UIKit
import Combine

class OtherBudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlet
    @IBOutlet weak var budgetTableView: UITableView!
    
    // MARK: - ViewModel
    private let viewModel = OtherBudgetViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Variable
    var otherBudgetData: [Budget] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        subscribe()
    }
    
    // MARK: - Actions
    @IBAction func moveToAddBudget(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "AddEditBudget", bundle: nil)
        let addOtherBudgetVC = storyBoard.instantiateViewController(withIdentifier: "addOtherBudget")
        
        // Half Sheet
        if let presentationController = addOtherBudgetVC.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(addOtherBudgetVC, animated: true)
    }
    
    // MARK: - Functions
    private func register() {
        budgetTableView.register(UINib(nibName: "OtherBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherBudgetTableViewCell")
    }
    
    private func subscribe() {
        viewModel.$otherBudget
            .sink { [weak self] items in
                self?.otherBudgetData = items
                DispatchQueue.main.async {
                    self?.budgetTableView.reloadData()
                }
            }.store(in: &anyCancellable)
    }
}

extension OtherBudgetViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherBudgetData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = budgetTableView.dequeueReusableCell(withIdentifier: "OtherBudgetTableViewCell") as? OtherBudgetTableViewCell else {
            fatalError("cell not found!")
        }
        
        cell.otherBudget = otherBudgetData[indexPath.row]
        
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
