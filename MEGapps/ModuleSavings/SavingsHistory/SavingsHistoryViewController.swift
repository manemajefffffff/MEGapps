//
//  SavingsHistoryViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 02/11/21.
//

import UIKit
import Combine

class SavingsHistoryViewController: UIViewController {
    
//MARK: - Outlets
    @IBOutlet weak var tableViewSavingsHistory: UITableView!
    
//MARK: - Variables
    private let savingsListViewModel = SavingsHistoryViewModel()
    var anyCancellable = Set<AnyCancellable>()
    let dateFormatter = DateFormatter()
    var delegate: updateViewProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // addData()
        prepTableView(tableView: tableViewSavingsHistory)
       // print(coreDataManager.get())
        // Do any additional setup after loading the view.
        subscribe()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.updateView()
    }

    // MARK: - Functions
    func prepTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "SavingsHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingsHistoryCell")
        
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
    }
    
    func subscribe() {
        savingsListViewModel.$savingHistory
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableViewSavingsHistory.reloadData()
                }
            }.store(in: &anyCancellable)
    }
    
    /* //Dummy Data
    func addData() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {fatalError()}

        let newData = SavingsHistory(context: context)
        newData.id = UUID()
        newData.createdAt = Date()
        newData.wordings = "one"
        newData.amount = 12345
        newData.status = "debit"
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
     */
    
//MARK: - Actions
    @IBAction func dismissPage(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView Extension
extension SavingsHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savingsListViewModel.savingHistory.count
        //return Items.count// get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewSavingsHistory.dequeueReusableCell(withIdentifier: "SavingsHistoryCell") as? SavingsHistoryTableViewCell else {
            fatalError("cell not found!")
        }
        let dateTime = savingsListViewModel.savingHistory[indexPath.row].createdAt// get dateTime coredata
        let amount = savingsListViewModel.savingHistory[indexPath.row].amount// get amount coredata
        let details = savingsListViewModel.savingHistory[indexPath.row].wordings// get details coredata
        let status = savingsListViewModel.savingHistory[indexPath.row].status
        
        dateFormatter.dateFormat = "MM-d-yy"
        
        cell.labelDateTime.text = "\(dateFormatter.string(from: dateTime!))"
        cell.labelAmount.text = "Rp. \(amount.formattedWithSeparator)"
        cell.labelDetails.text = details
        
        if status == "credit" {cell.labelAmount.textColor = UIColor(named: "DebitAmountGreen")}// Change var amount with actual var
        else if status == "debit" {cell.labelAmount.textColor = UIColor(named: "CreditAmountRed")}// Change var amount with actual var
        
        return cell
    }
}
