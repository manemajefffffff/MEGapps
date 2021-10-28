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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepCustomView(view: viewHobbySavingsCell)
        prepTableView(TV: tableViewSavingsBudget)
        
        // Do any additional setup after loading the view.
    }
    
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
        
        TV.separatorStyle = .none
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

extension SavingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return Items.count //get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewSavingsBudget.dequeueReusableCell(withIdentifier: "SavingsBudgetCell") as? SavingsBudgetTVC else {
            fatalError("cell not found!")
        }
        //let Product = Items[indexPath.row] //get product coredata
        
        //cell.labelProductName.text = Product.name //get Product Name
        //cell.labelProductPrice.text = Product.price //get Product Price
        
        cell.viewSavingsBudget.layer.cornerRadius = 16.0 // View Rounded; Modify this to match
        cell.viewSavingsBudget.layer.shadowColor = UIColor.black.cgColor // View DropShadow
        cell.viewSavingsBudget.layer.shadowRadius = 4.0
        cell.viewSavingsBudget.layer.shadowOpacity = 0.8
        cell.viewSavingsBudget.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.viewSavingsBudget.layer.masksToBounds = false
        
        return cell
    }
}
