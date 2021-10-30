//
//  SameItemViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 29/10/21.
//

import UIKit

class PurchaseSameItemViewController: UIViewController {

//MARK: - Outlets & Variables
    @IBOutlet weak var barButtonBack: UIBarButtonItem!
    @IBOutlet weak var barButtonNext: UIBarButtonItem!
    @IBOutlet weak var tableViewItems: UITableView!
    
    var name = ["Product Ichi", "Producto es Dos", "Produccione la Tiga"]
    var deadline = ["11 - 11 - 1111", "21 - 12 - 2112", "10 - 01 - 1001"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepTableView(TV: tableViewItems)
        
        // Do any additional setup after loading the view.
    }
    
    func prepTableView(TV: UITableView) {
        TV.delegate = self
        TV.dataSource = self
        
        TV.register(UINib.init(nibName: "PurchaseSameItemTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseSameItemCell")
        
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

extension PurchaseSameItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return Items.count //get product coredata
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewItems.dequeueReusableCell(withIdentifier: "PurchaseSameItemCell") as? PurchaseSameItemTableViewCell else {
            fatalError("cell not found!")
        }
        let productName = name[indexPath.row] //get product coredata
        let productDeadline = deadline[indexPath.row] //get product coredata
        
        
        cell.labelProductName.text = productName //get Product Name
        cell.labelProductDeadline.text = productDeadline //get Product Deadline
        
        return cell
    }
}
