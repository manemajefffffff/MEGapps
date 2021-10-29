//
//  CustomSingleTableViewCell.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//  This custom cell is not clickable, normal cell only
//

import Foundation
import UIKit

class CustomSingleTableViewCell: UITableViewCell {
    static let identifier = "CustomSigleTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "PureWhite")
        textLabel?.textAlignment = .left
        textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
