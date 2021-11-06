//
//  SavingsViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 26/10/21.
//

import UIKit


class SavingsViewController: UIViewController {

//MARK: - Outlets
    @IBOutlet weak var viewHobbySavingsCell: HobbySavingsCellView!
    @IBOutlet weak var tableViewSavingsBudget: UITableView!
    
//MARK: - Variables
    var name = ["one", "two", "three"]
    var price = ["123", "456", "789"]
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepCustomView(view: viewHobbySavingsCell)
        hobbySavingsCellAmountUpdate()
        prepTableView(TV: tableViewSavingsBudget)
        movePage()
        // Do any additional setup after loading the view.
    }
    
//MARK: - Functions
    func prepCustomView(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor // View DropShadow
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16.0 // View Rounded
    }
    
    func prepTableView(TV: UITableView) {
        TV.delegate = self
        TV.dataSource = self
        
        TV.register(UINib.init(nibName: "SavingsBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingsBudgetCell")
        
        TV.separatorStyle = .none
        TV.showsVerticalScrollIndicator = false
    }
    
    func hobbySavingsCellAmountUpdate() {
        //viewHobbySavingsCell.labelSavingsAmount.text = "Rp. \(SavingsHistory.amount)"// Get SavingsHistory.amount from CoreData.
    }
    
    func movePage() {
        
        viewHobbySavingsCell.historyButtonPressed = {
            let storyBoard = UIStoryboard(name: "SavingsHistory", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "savingHistoryPage")
            self.present(vc, animated: true)
        }
        
        viewHobbySavingsCell.addButtonPressed = {
            let storyBoard = UIStoryboard(name: "SavingsAdd", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "savingAddPage")
            self.present(vc, animated: true)
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

//MARK: - TableView Extension
extension SavingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return Items.count //get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewSavingsBudget.dequeueReusableCell(withIdentifier: "SavingsBudgetCell") as? SavingsBudgetTableViewCell else {
            fatalError("cell not found!")
        }
        let productName = name[indexPath.row] //get product coredata
        let productPrice = price[indexPath.row] //get product coredata
        
        
        cell.labelProductName.text = productName //get Product Name
        cell.labelProductPrice.text = productPrice //get Product Price
        
        cell.viewSavingsBudgetCell.layer.cornerRadius = 16.0 // View Rounded; Modify this to match
        cell.viewSavingsBudgetCell.layer.shadowColor = UIColor.black.cgColor // View DropShadow
        cell.viewSavingsBudgetCell.layer.shadowRadius = 2.0
        cell.viewSavingsBudgetCell.layer.shadowOpacity = 0.4
        cell.viewSavingsBudgetCell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.viewSavingsBudgetCell.layer.masksToBounds = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //move to item detail
    }
}
