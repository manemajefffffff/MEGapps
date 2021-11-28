//
//  AllocateOtherBudgetView.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import Foundation
import UIKit
import Combine

class AllocateOtherBudgetView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlet
    @IBOutlet weak var insufficientAmountLabel: UILabel!
    @IBOutlet weak var usedBudgetLabel: UILabel!
    @IBOutlet weak var allocateBudgetTableView: UITableView!
    @IBOutlet weak var proceedWishlistButton: UIButton!
    
    // MARK: - Containers
    var itemContainer: Items?
    var insufficientAmountContainer: Int64 = 0
    
    // MARK: - ViewModel
    let viewModel = AllocateOtherBudgetViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        subscribe()
        sendReceivedDataToVM()
    }
    
    // MARK: - Function
    private func sendReceivedDataToVM() {
        viewModel.item = itemContainer
        viewModel.insufficientAmount = insufficientAmountContainer
        insufficientAmountLabel.text = "\(insufficientAmountContainer)"
    }
    
    private func subscribe() {
        // subscribe untuk budget used
        viewModel.$budgetUsed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.allocateBudgetTableView.reloadData()
                }
            }.store(in: &anyCancellable)
        
        // susbcribe untuk total jumlah budget lain yang terpakai
        viewModel.$budgetAmountUsed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setOtherBudgetUsedTotal()
            }.store(in: &anyCancellable)
        
        viewModel.$isBudgetAllocatedEnough
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setProceedWishlistButtonState()
            }.store(in: &anyCancellable)
    }
    
    private func setOtherBudgetUsedTotal() {
//        usedBudgetLabel.text = "Rp. \(viewModel.budgetAmountUsed)"
        usedBudgetLabel.text = "\(FormatNumberHelper.formatNumber(price: viewModel.budgetAmountUsed))"
    }
    
    private func setProceedWishlistButtonState() {
        proceedWishlistButton.isEnabled = viewModel.isBudgetAllocatedEnough
    }
    
    private func register() {
        allocateBudgetTableView.register(UINib(nibName: "AllocateOtherBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "AllocateOtherBudgetTableViewCell")
    }
    
    private func addAlert() {
        let alert = UIAlertController(title: "Proceed Wishlist", message: "Are you sure you want to proceed with this wishlist?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            // move page to purchase overview
            self.viewModel.proceedWishlist()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
//    private func changeAmountWillUsed(amount: Int64, index: Int) {
//        viewModel.setOtherBudgetUsageAmount(amountUsed: amount, index: index)
//    }
//
//    private func deleteBudgetUsed(index: Int) {
//        viewModel.deleteUsedBudget(index: index)
//    }
    
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
        guard let useOtherBudgetVC = storyBoard.instantiateViewController(withIdentifier: "useBudgetsPage") as? UseBudgetsView else {
            fatalError()
        }
        useOtherBudgetVC.budgetUsed = self.viewModel.budgetUsed
        useOtherBudgetVC.budgetNotUsed = self.viewModel.budgetNotUsed
        useOtherBudgetVC.delegate = self
        
        let navController = UINavigationController(rootViewController: useOtherBudgetVC)
        
        self.present(navController, animated: true)
    }
    
}

// MARK: - TableView Function
extension AllocateOtherBudgetView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.budgetUsed.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = allocateBudgetTableView.dequeueReusableCell(withIdentifier: "AllocateOtherBudgetTableViewCell") as? AllocateOtherBudgetTableViewCell else {
                fatalError("cell not found!")
            }
            cell.id = indexPath.row
            cell.budget = viewModel.budgetUsed[indexPath.row]
            cell.delegate = self
//            cell.changeAmoutBudgetUsed = self.changeAmountWillUsed(amount:index:)
//            cell.deleteBudgetUsed = self.deleteBudgetUsed(index:)
            
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? AllocateOtherBudgetTableViewCell
        let amountWillUse = selectedCell?.budgetAmountToUse ?? 0
        self.viewModel.setOtherBudgetUsageAmount(amountUsed: amountWillUse, index: indexPath.row)
    }
}

extension AllocateOtherBudgetView: backToAllocateOtherBudgetView {
    func sendBack(budgetUsed: [BudgetUsed], budgetNotUsed: [BudgetUsed]) {
        self.viewModel.budgetUsed = budgetUsed
        self.viewModel.budgetNotUsed = budgetNotUsed
    }
}

extension AllocateOtherBudgetView: ChangeBudgetUsedAmountProtocol {
    func deleteBudgetUsed(index: Int) {
        viewModel.deleteUsedBudget(index: index)

    }
    
    func changeAmountWillUsed(amount: Int64, index: Int) {
        viewModel.setOtherBudgetUsageAmount(amountUsed: amount, index: index)
    }
}

class ButtonCellView: UITableViewCell {
    @IBOutlet weak var useOtherBudgetButton: UIButton!
}
