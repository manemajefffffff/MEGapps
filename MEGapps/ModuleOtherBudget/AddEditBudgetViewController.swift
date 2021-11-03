//
//  AddEditBudgetViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 02/11/21.
//

import UIKit

class AddEditBudgetViewController: UIViewController {

    @IBOutlet weak var budgetNameTF: UITextField!
    @IBOutlet weak var budgetAmtTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageShadowView()
    }
    
    func manageShadowView() {
        self.budgetNameTF.layer.shadowColor = UIColor(hex: "bbbbbb")?.cgColor
        self.budgetNameTF.layer.shadowRadius = 0.4
        self.budgetNameTF.layer.shadowOpacity = 0.1
        self.budgetNameTF.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.budgetNameTF.layer.masksToBounds = false
        
        self.budgetAmtTF.layer.shadowColor = UIColor(hex: "bbbbbb")?.cgColor
        self.budgetAmtTF.layer.shadowRadius = 0.4
        self.budgetAmtTF.layer.shadowOpacity = 0.1
        self.budgetAmtTF.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.budgetAmtTF.layer.masksToBounds = false
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
