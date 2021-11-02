//
//  CustomDoubleTableViewCell.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation
import UIKit

class CustomDoubleTableViewCell: UITableViewCell {
    static let identifier = "CustomDoubleTableViewCell"
    
    lazy var rightTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    func setupCell(rightValue: String) {
        self.rightTextLabel.text = rightValue
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "PureWhite")
        textLabel?.textAlignment = .left
        textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        self.addSubview(rightTextLabel)
        rightTextLabel.textAlignment = .right
        NSLayoutConstraint.activate([
            rightTextLabel.topAnchor.constraint(equalTo: self.topAnchor),
            rightTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            rightTextLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
