//
//  SavingsHistoryViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 02/11/21.
//

import UIKit

class SavingsHistoryViewController: UIViewController {
    
//MARK: - Outlets
    @IBOutlet weak var tableViewSavingsHistory: UITableView!
    
//MARK: - Variables
    var dateTime = ["21-12-2112, 12:34", "12-12-1212, 12:12", "10-01-1001, 10:01"]
    var amount = ["Rp. 123.456", "Rp. 456.654", "Rp. 789.000"]
    var details = ["one", "two", "three"]
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepTableView(TV: tableViewSavingsHistory)
        // Do any additional setup after loading the view.
    }

//MARK: - Functions
    func prepTableView(TV: UITableView) {
        TV.delegate = self
        TV.dataSource = self
        
        TV.register(UINib.init(nibName: "SavingsHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingsHistoryCell")
        
        TV.separatorStyle = .singleLine
        TV.showsVerticalScrollIndicator = false
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
extension SavingsHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return Items.count// get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewSavingsHistory.dequeueReusableCell(withIdentifier: "SavingsHistoryCell") as? SavingsHistoryTableViewCell else {
            fatalError("cell not found!")
        }
        let dateTime = dateTime[indexPath.row]// get dateTime coredata
        let amount = amount[indexPath.row]// get amount coredata
        let details = details[indexPath.row]// get details coredata
        
        cell.labelDateTime.text = dateTime
        cell.labelAmount.text = amount
        cell.labelDetails.text = details
        
        if details == "one" {cell.labelAmount.textColor = UIColor(named: "CreditAmountRed")}// Change var amount with actual var
        else if details == "two" {cell.labelAmount.textColor = UIColor(named: "DebitAmountGreen")}// Change var amount with actual var
        
        return cell
    }
}
