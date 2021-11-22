//
//  SameItemViewController.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 29/10/21.
//

import UIKit
import Combine

class PurchaseSameItemViewController: UIViewController {

// MARK: - ViewModel
    private let purchaseSameItemVM = PurchaseSameItemViewModel()
    var anyCancellable = Set<AnyCancellable>()

// MARK: - Outlets
    @IBOutlet weak var barButtonBack: UIBarButtonItem!
    @IBOutlet weak var barButtonNext: UIBarButtonItem!
    @IBOutlet weak var tableViewItems: UITableView!
    
// MARK: - Variables
    //Dummy; For Debug Purposes ONLY
    var name = ["Product Ichi", "Producto es Dos", "Produccione la Tiga"]
    var deadline = ["11 - 11 - 1111", "21 - 12 - 2112", "10 - 01 - 1001"]
    var wishlistAdd : WishlistAddViewModel?
    
    var productName: String = ""
    var productDeadline: String = ""
    let dateFormatter = DateFormatter()
    var categoryChosen: String = ""
    var numberOfItemSameCat = 0

    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepTableView(TV: tableViewItems)
        
        print("wishlist Add", wishlistAdd?.items)
        
        subscribe()
        // Do any additional setup after loading the view.
    }
    
// MARK: - Actions
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        //ifSameItemCheck?
        
        let storyBoard = UIStoryboard(name: "WishlistOverview", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "WishlistOverviewSB") as? WishlistOverviewViewController else {
            fatalError("no view")
        }
        vc.wishlistAdd = wishlistAdd
        navigationController?.pushViewController(vc, animated: true)
    }
    
// MARK: - Functions
    func prepTableView(TV: UITableView) {
        TV.delegate = self
        TV.dataSource = self
        
        TV.register(UINib.init(nibName: "PurchaseSameItemTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseSameItemCell")
        
        TV.separatorStyle = .singleLine
        TV.showsVerticalScrollIndicator = false
    }
    
    func retrieveData() {
        purchaseSameItemVM.fetchData()
    }
    
    func subscribe() {
        purchaseSameItemVM.$items.receive(on: DispatchQueue.main).sink { [weak self] _ in DispatchQueue.main.async {
            self?.tableViewItems.reloadData()
            }
        }.store(in: &anyCancellable)
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
extension PurchaseSameItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableViewItems.dequeueReusableCell(withIdentifier: "PurchaseSameItemCell") as? PurchaseSameItemTableViewCell else {
                fatalError("cell not found!")
            }
            dateFormatter.dateFormat = "dd - MM - YYYY"
            
            if purchaseSameItemVM.items[indexPath.row].category == categoryChosen {
                productName = purchaseSameItemVM.items[indexPath.row].name ?? "" //get name coredata
                productDeadline = dateFormatter.string(from: purchaseSameItemVM.items[indexPath.row].deadline ?? Date()) //get deadline coredata
                numberOfItemSameCat += 1
            }
            
            cell.labelProductName.text = productName //get Product Name
            cell.labelProductDeadline.text = productDeadline //get Product Deadline
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numberOfItemSameCat
        }
}
