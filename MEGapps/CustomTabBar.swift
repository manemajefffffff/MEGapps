//
//  CustomTabBar.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import Foundation
import UIKit

@IBDesignable class CustomTabBar: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radius: CGFloat = 20
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -3)
        shapeLayer.shadowOpacity = 0.4
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: 0.0))
        
        
        return path.cgPath
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame

        // MARK: - BAGIAN YANG BIKIN LAG
//        tabFrame.size.height = 65 + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero)
//        tabFrame.origin.y = self.frame.origin.y + (self.frame.height - 65 - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero))

        tabFrame.size.height = 65 + (window?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y = self.frame.origin.y + (self.frame.height - 65 - (window?.safeAreaInsets.bottom ?? CGFloat.zero))
        // MARK: - END OF BAGIAN YANG BIKIN LAG

        self.layer.cornerRadius = 20
        self.frame = tabFrame

        self.items?.forEach({$0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0)})
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        return CGSize(width: superSize.width, height: 65 + (window?.safeAreaInsets.bottom ?? CGFloat.zero))
    }
}
