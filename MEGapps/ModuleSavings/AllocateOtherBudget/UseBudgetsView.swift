//
//  UseBudgetView.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import Foundation
import UIKit
import Combine

protocol backToAllocateOtherBudgetView: AnyObject {
    func sendBack(budgetUsed: [BudgetUsed], budgetNotUsed: [BudgetUsed])
}

class UseBudgetsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var useBudgetTableView: UITableView!
    
    // MARK: - ViewModel
    private let viewModel = UseOtherBudgetViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Container
    var budgetUsed: [BudgetUsed]?
    var budgetNotUsed: [BudgetUsed]?
    
    // MARK: - Delegate
    weak var delegate: backToAllocateOtherBudgetView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTableView()
        subscribe()
        sendDataToVM()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.useBudgetTableView.reloadData()
        }
    }
    
    // MARK: - Functions
    private func subscribe() {
        viewModel.$budgetNotUsed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadTableView()
            }.store(in: &anyCancellable)
    }
    private func sendDataToVM() {
        if let budgetUsed = budgetUsed {
            viewModel.budgetUsed = budgetUsed
        }
        if let budgetNotUsed = budgetNotUsed {
            viewModel.budgetNotUsed = budgetNotUsed
        }
    }
    
    // MARK: - Actions
    @IBAction func dismissPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBudget(_ sender: Any) {
        viewModel.saveChanges()
        dismiss(animated: true) {
            self.delegate?.sendBack(budgetUsed: self.viewModel.budgetUsed,
                                    budgetNotUsed: self.viewModel.budgetNotUsed)
        }
    }
    
}

extension UseBudgetsView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.budgetNotUsed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = useBudgetTableView.dequeueReusableCell(withIdentifier: "useBudgetCell") as? UseBudgetCell else {
            fatalError("no cell found")
        }
        cell.budgetNameLabel.text = viewModel.budgetNotUsed[indexPath.row].budget?.name
        cell.budgetLeftLabel.text = "\(viewModel.budgetNotUsed[indexPath.row].budget?.amount ?? 0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.changeIsUsedStatus(index: indexPath.row)
    }
}

class UseBudgetCell: UITableViewCell {
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetLeftLabel: UILabel!
}
