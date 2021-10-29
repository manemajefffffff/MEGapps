//
//  BudgetAllocationTableView.swift
//  MEGapps
//
//  Created by Arya Ilham on 29/10/21.
//

import UIKit

class BudgetAllocationTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        dropShadow()
    }
    
    func dropShadow() {
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor // any value you want
        self.layer.shadowOpacity = 0.3 // any value you want
        self.layer.shadowRadius = 2 // any value you want
        self.layer.shadowOffset = .init(width: 0, height: 3) // any value you want
    }

}
