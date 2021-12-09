//
//  SavingsViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 26/10/21.
//

import UIKit
import Combine

protocol updateViewProtocol: AnyObject {
    func updateView()
    func updateSavingListView()
    func updateSavingsAmountView()
}

protocol SavingsViewControllerDelegate: AnyObject {
    func didSave( triggerCheck: Bool)
}

class SavingsViewController: UIViewController {

    // MARK: - ViewModel
    private let savingsViewModel = SavingsViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Outlets
    @IBOutlet weak var viewHobbySavingsCell: HobbySavingsCellView!
    @IBOutlet weak var tableViewSavingsBudget: UITableView!
    @IBOutlet weak var emptyStateView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationService.shared.requestAuthorization()
//        prepCustomView(view: viewHobbySavingsCell)
        prepTableView(view: tableViewSavingsBudget)
        self.updateView()// init call to get data
        movePage()
        subscribe()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateView()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Button
    @IBAction func goToWishlistBtn(_ sender: Any) {
        tabBarController!.selectedIndex = 1
    }
    
    
    // MARK: - Functions
    func emptyState() {
        if savingsViewModel.items.count == 0 { // Needs fix where savingsViewModel.items WHERE .status == on_progress is 0 check
            emptyStateView.isHidden = false
        } else {
            emptyStateView.isHidden = true
        }
//        emptyStateView.isHidden = true
    }
    
    func prepCustomView(view: HobbySavingsCellView) {// unused
        view.layer.shadowColor = UIColor.black.cgColor // View DropShadow
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16.0 // View Rounded
    }
    
    func prepTableView(view: UITableView) {
        view.delegate = self
        view.dataSource = self
        view.register(UINib.init(nibName: "SavingsBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingsBudgetCell")
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
    }
    
    func subscribe() {
//        savingsViewModel.$savingsHistory
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in
//                DispatchQueue.main.async {
//                    self?.tableViewSavingsBudget.reloadData()
//                }
//            }
//            .store(in: &anyCancellable)
        savingsViewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableViewSavingsBudget.reloadData()
                }
                self?.emptyState()
            }.store(in: &anyCancellable)
        
        savingsViewModel.$total
            .receive(on: DispatchQueue.main)
            .sink { [weak self] total in
                DispatchQueue.main.async {
                    self?.viewHobbySavingsCell.savingAmount = total
                    self?.viewHobbySavingsCell.updateView()
                }
            }
            .store(in: &anyCancellable)
    }
    
    func movePage() {
        viewHobbySavingsCell.historyButtonPressed = {
            let storyBoard = UIStoryboard(name: "SavingsHistory", bundle: nil)
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "savingHistoryPage") as? SavingsHistoryViewController else {
                fatalError("View not available")
            }
            viewController.delegate = self
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }
        viewHobbySavingsCell.addButtonPressed = {
            self.goToAddDeductSavings(isAdd: true)
        }
        viewHobbySavingsCell.deductButtonPressed = {
            self.goToAddDeductSavings(isAdd: false)
        }
    }
    
    private func goToAddDeductSavings(isAdd: Bool) {
        let storyBoard = UIStoryboard(name: "SavingsAdd", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "savingAddPage") as? SavingsAddViewController else {
            fatalError("View not available")
        }
        viewController.delegate = self
        viewController.isAddContainer = isAdd
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableView Extension
extension SavingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savingsViewModel.items.count
//         return Items.count // get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewSavingsBudget.dequeueReusableCell(withIdentifier: "SavingsBudgetCell") as? SavingsBudgetTableViewCell else {
            fatalError("cell not found!")
        }
        cell.newData = savingsViewModel.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // move to item detail
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = PurchaseDetailViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.delegate = self
        viewController.itemsPD = savingsViewModel.items[indexPath.row]
//        let navPurcDetail: UINavigationController = UINavigationController(rootViewController: viewController)
//        navPurcDetail.modalPresentationStyle = .fullScreen
//        self.present(navPurcDetail, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
        
//        tableView.deselectRow(at: indexPath, animated: true)
//        let viewController = PurchaseDetailViewController()
//        viewController.itemsPD = savingsViewModel.items[indexPath.row]
//        self.navigationController?.pushViewController(viewController, animated: true)
//        print("Pekora peko")
    }
}

extension SavingsViewController: updateViewProtocol {
    func updateSavingsAmountView() {
        self.savingsViewModel.fetchData()
    }
    
    func updateSavingListView() {
        self.savingsViewModel.fetchDataItems()
    }
    
    func updateView() {
        self.savingsViewModel.fetchData()
        self.savingsViewModel.fetchDataItems()
//        self.subscribe()
    }
}

extension SavingsViewController: SavingsViewControllerDelegate {
    func didSave(triggerCheck: Bool) {
        if triggerCheck {// This doesn't work? ProtDel works fine, but the CoreData Value doesn't update until page change. BROKEN
//            self.updateView()
            self.updateSavingsAmountView()
//            subscribe()
            print("\(savingsViewModel.total)DELEGATE BS HERE")
        }
    }
}
