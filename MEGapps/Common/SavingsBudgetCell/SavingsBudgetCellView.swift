//
//  SavingsBudgetCellView.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 27/10/21.
//

import UIKit

@IBDesignable
final class SavingsBudgetCellView: UIView {
    
//MARK: - Outlets
    
    @IBOutlet weak var imageStar: UIImageView!
    @IBOutlet weak var imageChevronRight: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
//MARK: - Load Custom UIView NIB
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "SavingsBudgetCellView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configureView(name: String, price: String) {
        self.labelProductName.text = name
        self.labelProductPrice.text = price
    }

}