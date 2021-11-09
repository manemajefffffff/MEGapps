//
//  SavingsViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 26/10/21.
//

import UIKit

class SavingsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var viewHobbySavingsCell: HobbySavingsCellView!
    @IBOutlet weak var tableViewSavingsBudget: UITableView!
    
    // MARK: - Variables
    var savingAmount = 0
    var historyData = Dummy.getDummyData()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepCustomView(view: viewHobbySavingsCell)
        prepTableView(view: tableViewSavingsBudget)
        movePage()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func prepCustomView(view: HobbySavingsCellView) {
        view.layer.shadowColor = UIColor.black.cgColor // View DropShadow
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16.0 // View Rounded
        
        view.savingAmount = self.savingAmount
    }
    
    func prepTableView(view: UITableView) {
        view.delegate = self
        view.dataSource = self
        view.register(UINib.init(nibName: "SavingsBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingsBudgetCell")
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
    }
    
    func movePage() {
        viewHobbySavingsCell.historyButtonPressed = {
//            self.updateView()
            let storyBoard = UIStoryboard(name: "SavingsHistory", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "savingHistoryPage")
            self.present(viewController, animated: true)
        }
        viewHobbySavingsCell.addButtonPressed = {
            let storyBoard = UIStoryboard(name: "SavingsAdd", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "savingAddPage")
            self.present(viewController, animated: true)
        }
    }
    
    /// Update view trigger
    func updateView() {
        viewHobbySavingsCell.savingAmount = self.savingAmount
        viewHobbySavingsCell.updateView()
        historyData = Dummy.getDummyData()
        tableViewSavingsBudget.reloadData()
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
        return historyData.count
        // return Items.count // get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewSavingsBudget.dequeueReusableCell(withIdentifier: "SavingsBudgetCell") as? SavingsBudgetTableViewCell else {
            fatalError("cell not found!")
        }
        cell.labelProductName.text = historyData[indexPath.row].wordings // get Product Name
        cell.labelProductPrice.text = historyData[indexPath.row].amount // get Product Price
        
        cell.viewSavingsBudgetCell.layer.cornerRadius = 16.0 // View Rounded; Modify this to match
        cell.viewSavingsBudgetCell.layer.shadowColor = UIColor.black.cgColor // View DropShadow
        cell.viewSavingsBudgetCell.layer.shadowRadius = 2.0
        cell.viewSavingsBudgetCell.layer.shadowOpacity = 0.4
        cell.viewSavingsBudgetCell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.viewSavingsBudgetCell.layer.masksToBounds = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // move to item detail
    }
}

/// dummy class
class Dummy {
    var wordings: String
    var amount: String
    
    let randString: [String] = ["Kemuel", "Tooru", "Cephas", "Ilai", "Azrael"]
    
    init() {
        self.wordings = randString[Int.random(in: 0..<5)]
        self.amount = "\(Int.random(in: 1..<100)*10000)"
    }
    
    static func getDummyData() -> [Dummy] {
        let counter = Int.random(in: 1..<10)
        var dummyData: [Dummy] = []
        for idx in 0...counter-1 {
            dummyData.append(Dummy())
        }
        return dummyData
    }
}
