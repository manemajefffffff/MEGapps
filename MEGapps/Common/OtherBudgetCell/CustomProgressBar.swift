//
//  CustomProgressBar.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 23/11/21.
//

import Foundation
import UIKit

@IBDesignable
class CustomProgressBar: UIView {
    @IBInspectable var color: UIColor? = .gray {
        didSet {setNeedsDisplay()}
    }
    var progress: CGFloat = 0.5 {
        didSet {setNeedsDisplay()}
    }

    private let bgMask = CAShapeLayer()
    private let progressLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }

    override func draw(_ rect: CGRect) {
        bgMask.path =  UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.5).cgPath
        layer.mask = bgMask

        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))

        progressLayer.frame =  progressRect
        progressLayer.backgroundColor = UIColor(named: "AddAmountAndSelectedIndicator")?.cgColor


    }
}
