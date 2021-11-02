//
//  HobbySavingsCellView.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 26/10/21.
//

import UIKit

@IBDesignable
final class HobbySavingsCellView: UIView {

//MARK: - Outlets
    @IBOutlet weak var labelHobbySavings: UILabel!
    @IBOutlet weak var labelSavingsAmount: UILabel!
    @IBOutlet weak var buttonHistory: UIButton!
    @IBOutlet weak var buttonEye: UIButton!
    @IBOutlet weak var buttonAddAmount: UIButton!
    
//MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
//MARK: - Functions
    func loadViewFromNib(nibName: String) -> UIView? {// Load Custom UIView NIB
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "HobbySavingsCellView") else {return}
        view.frame = self.bounds
        view.layer.cornerRadius = 16.0 // View Rounded
        self.addSubview(view)
        self.buttonAddAmount.layer.cornerRadius = 16.0 // Button Rounded
    }
    
    func configureView(title: String) {
        self.labelSavingsAmount.text = title
    }

}
