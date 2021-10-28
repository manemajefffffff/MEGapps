//
//  OtherBudgetCellView.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 27/10/21.
//

import UIKit

@IBDesignable
final class OtherBudgetCellView: UIView {

//MARK: - Outlets
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var imageChevronRight: UIImageView!
    
    
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
        guard let view = self.loadViewFromNib(nibName: "OtherBudgetCellView") else {return}
        view.frame = self.bounds
        view.layer.cornerRadius = 16.0 // View Rounded
        self.addSubview(view)
    }
    
    func configureView(name: String, price: String) {
        self.labelProductName.text = name
        self.labelProductPrice.text = price
    }

}
