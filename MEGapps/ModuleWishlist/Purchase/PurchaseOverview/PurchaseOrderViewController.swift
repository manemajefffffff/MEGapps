//
//  PurchaseOrderViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 28/10/21.
//

import UIKit

class PurchaseOrderViewController: UIViewController, BudgetAllocationTVCProtocol, ProductInformationTVCProtocol {
    func changepiHeight(piHeight: CGFloat) {
        DispatchQueue.main.async {
            self.productInfoHeight?.constant = piHeight
            self.productInfoUiView.layoutIfNeeded()
        }
    }
    
    func changeHeight(baHeight: CGFloat) {
        DispatchQueue.main.async {
            self.viewHeight?.constant = baHeight
            self.allocBudgUiView.layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var productInfoHeight: NSLayoutConstraint!
    @IBOutlet var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var allocBudgUiView: UIView!
    @IBOutlet weak var productInfoUiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
//    override func viewWillLayoutSubviews() {
//        super.updateViewConstraints()
//        self.productInfoHeight?.constant =
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "allocToPurchase" {
            guard let dest = segue.destination as? BudgetAllocationOverviewTableViewController
            else {return}
            dest.delegate = self
            return
        }
//        if let childViewController = segue.destination as? BudgetAllocationOverviewTableViewController {
//            childViewController.view.translatesAutoresizingMaskIntoConstraints = false
//    }
    
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
