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
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: - ViewModel
    private let viewModel = OtherBudgetViewModel()
    var anyCancellable = Set<AnyCancellable>()
    
    // MARK: - Variable
    var container: [Budget] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        subscribe()
        setupEmptyState()
        //addData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: - Actions
    @IBAction func moveToAddBudget(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "AddEditBudget", bundle: nil)
        guard let addOtherBudgetVC = storyBoard.instantiateViewController(withIdentifier: "addOtherBudget") as? AddEditBudgetViewController else {
            fatalError()
        }
        addOtherBudgetVC.delegate = self
        let navController = UINavigationController(rootViewController: addOtherBudgetVC)
        // Half Sheet
        if let presentationController = navController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        self.present(navController, animated: true)
    }
    
    // MARK: - Functions
    private func register() {
        budgetTableView.register(UINib(nibName: "OtherBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherBudgetTableViewCell")
    }
    
    private func subscribe() {
        viewModel.$otherBudget
            .sink { [weak self] items in
                self?.container = items
                DispatchQueue.main.async {
                    self?.budgetTableView.reloadData()
                }
            }.store(in: &anyCancellable)
        
        viewModel.$otherBudget
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in
                self?.setupEmptyState()
            }.store(in: &anyCancellable)
    }
    
    private func setupEmptyState() {
        if !noDataView.isDescendant(of: budgetTableView) {
            budgetTableView.addSubview(noDataView)
        }
        
        if viewModel.hasItem {
            noDataView.isHidden = true
        } else {
            noDataView.isHidden = false
        }
    }
    
    private func addData() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {fatalError()}
        
        let budgetData = TrItemBudget(context: context)
        budgetData.id = UUID()
        budgetData.createdAt = Date()
        budgetData.amount = 10000
        
        let newData = Budget(context: context)
        newData.id = UUID()
        newData.amount = 300000
        newData.name = "MAMAM"
        
        newData.addToTrItemBudget(budgetData)
                
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}

extension OtherBudgetViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return container.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = budgetTableView.dequeueReusableCell(withIdentifier: "OtherBudgetTableViewCell") as? OtherBudgetTableViewCell else {
            fatalError("cell not found!")
        }
        
        cell.otherBudget = container[indexPath.row]
        cell.calculateData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "AddEditBudget", bundle: nil)
        guard let addOtherBudgetVC = storyBoard.instantiateViewController(withIdentifier: "addOtherBudget") as? AddEditBudgetViewController else {
            fatalError()
        }
        addOtherBudgetVC.delegate = self
        addOtherBudgetVC.oldBudgetData = viewModel.otherBudget[indexPath.row]
        let navController = UINavigationController(rootViewController: addOtherBudgetVC)
        // Half Sheet
        if let presentationController = navController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            
        }
        self.present(navController, animated: true)
    }
    
}

extension OtherBudgetViewController: AddEditBudgetDelegate {
    func refreshData() {
        viewModel.fetchData()
        
        if !viewModel.hasItem{
            print("check")
            container = []
        }
        print("check 2")
        setupEmptyState()
        budgetTableView.reloadData()
    }
}
