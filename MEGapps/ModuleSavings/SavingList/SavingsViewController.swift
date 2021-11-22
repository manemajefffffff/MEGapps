//
//  SavingsViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 26/10/21.
//

import UIKit
import Combine

protocol updateViewProtocol {
    func updateView()
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
        prepCustomView(view: viewHobbySavingsCell)
        prepTableView(view: tableViewSavingsBudget)
        self.updateView()// init call to get data
        movePage()
        subscribe()
        if savingsViewModel.savingsHistory.count == 0 {
            emptyStateView.isHidden = false
        } else {
            emptyStateView.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Button
    @IBAction func goToWishlistBtn(_ sender: Any) {
        tabBarController!.selectedIndex = 1
    }
    
    
    // MARK: - Functions
    func prepCustomView(view: HobbySavingsCellView) {
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
            self.present(navController, animated: true)
        }
        viewHobbySavingsCell.addButtonPressed = {
            let storyBoard = UIStoryboard(name: "SavingsAdd", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "savingAddPage")
            self.present(viewController, animated: true)
        }
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
        // return Items.count // get product coredata
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
    }
}

extension SavingsViewController: updateViewProtocol {
    func updateView() {
        self.savingsViewModel.fetchData()
        self.subscribe()
    }
}
