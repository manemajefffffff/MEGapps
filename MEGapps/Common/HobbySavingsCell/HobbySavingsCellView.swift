//
//  HobbySavingsCellView.swift
//  MEGapps
//
//  Created by William Giovanni Kambuno on 26/10/21.
//

import UIKit

@IBDesignable
final class HobbySavingsCellView: UIView {
    
//MARK: - Variables
    var historyButtonPressed: (() -> ()) = {}
    var addButtonPressed: (() -> ()) = {}
    var isOpen: Bool = false
    var savingAmount: Int = 0
    
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
        
        let gradient = CAGradientLayer()// Gradient
        gradient.frame = view.bounds
        gradient.colors = [UIColor(named: "PrimaryHSgradient")?.cgColor , UIColor(named: "SecondaryHSgradient")?.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 16.0
        view.layer.insertSublayer(gradient, at: 0)
        
        view.frame = self.bounds
        view.layer.cornerRadius = 16.0// View Rounded
        self.addSubview(view)
        self.buttonAddAmount.layer.cornerRadius = 16.0// Button Rounded
        
        self.labelSavingsAmount.text = "Rp. \(self.savingAmount.formattedWithSeparator)"
        self.showAmount()
    }
    
    func configureView(title: String) {
        self.labelSavingsAmount.text = title
    }
    
    func showAmount() {
        if isOpen {
            labelSavingsAmount.text = "Rp. \(self.savingAmount.formattedWithSeparator)"
        } else {
            labelSavingsAmount.text = "Rp *******"
        }
    }
    
    func updateView() {
        self.showAmount()
    }

    @IBAction func moveToSavingsHistory(_ sender: Any) {
        historyButtonPressed()
    }
    
    @IBAction func moveToAddAmount(_ sender: Any) {
        addButtonPressed()
    }
    
    @IBAction func hideAmount(_ sender: Any) {
        isOpen = !isOpen
        self.showAmount()
    }
    
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
