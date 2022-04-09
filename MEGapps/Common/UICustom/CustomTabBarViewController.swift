//
//  CustomTabBarViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 09/04/22.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShape()
    }
    
    private func addShape() {
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: self.tabBar.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 0.0)).cgPath
        
        layer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        layer.fillColor = UIColor(named: "PrimaryHSgradient")?.cgColor ?? UIColor.white.cgColor
        layer.lineWidth = 2
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -3)
        layer.shadowOpacity = 0.4
        layer.shadowPath = UIBezierPath(roundedRect: self.tabBar.bounds, cornerRadius: 20).cgPath
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
//        self.tabBar.layer.replaceSublayer(self.tabBar.layer, with: layer)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.isTranslucent = true
        var frame = self.tabBar.frame
        
        frame.size.height = 65 + (self.tabBar.window?.safeAreaInsets.bottom ?? CGFloat.zero)
        frame.origin.y = self.tabBar.frame.origin.y + (self.tabBar.frame.height - 65 - (self.tabBar.window?.safeAreaInsets.bottom ?? CGFloat.zero))

        self.tabBar.frame = frame
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.items?.forEach({$0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0)})
    }
    
}
