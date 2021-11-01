//
//  CustomActionTableViewCell.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation
import UIKit

class CustomActionTableViewCell: UITableViewCell {
    static let identifier = "CustomActionTableViewCell"
    
    var actionLabelButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "PureWhite")
        textLabel?.textAlignment = .left
        textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        textLabel?.textColor = UIColor(named: "ButtonTextGreen")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
