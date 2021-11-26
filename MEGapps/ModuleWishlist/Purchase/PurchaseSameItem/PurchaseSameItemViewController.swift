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
    
    var productName: [String] = []
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
        countData()
        setupEmptyState()
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
    
    func countData() {
        if let category = wishlistAdd?.items?.category {
            categoryChosen = category
        }
        
        for object in purchaseSameItemVM.items {
            if object.category == categoryChosen {
                productName.append(object.name ?? "None")
                numberOfItemSameCat += 1
            }
        }
    }
    
    func setupEmptyState() {
        if numberOfItemSameCat == 0 {
            print("zero")
            tableViewItems.isHidden = true
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 343, height: 50))
            
            self.view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            label.textAlignment = .center
            
            label.text = "You have no items in same category."
            label.textColor = .gray
        } else {
            print("has items")
        }
    }

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
            
        cell.labelProductName.text = productName[indexPath.row] //get Product Name //get Product Deadline
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numberOfItemSameCat
        }
}
