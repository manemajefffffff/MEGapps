//
//  BudgetAllocationTableView.swift
//  MEGapps
//
//  Created by Arya Ilham on 29/10/21.
//

import UIKit

class BudgetAllocationTableView: UITableView {
    override func awakeFromNib() {
        dropShadow()
        removeHeaderSection()
    }
    
    // MARK: - UI modification function
    private func dropShadow() {
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor // any value you want
        self.layer.shadowOpacity = 0.3 // any value you want
        self.layer.shadowRadius = 2 // any value you want
        self.layer.shadowOffset = .init(width: 0, height: 3) // any value you want
    }
    
    private func removeHeaderSection() {
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.tableHeaderView = UIView(frame: frame)
    }

}
