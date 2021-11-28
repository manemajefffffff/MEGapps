//
//  FormatNumberHelper.swift
//  MEGapps
//
//  Created by Arya Ilham on 28/11/21.
//

import Foundation

class FormatNumberHelper {
    
    static func formatNumber(price: Int64) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let formattedPrice = formatter.string(from: price as NSNumber) {
            return "Rp. \(formattedPrice)"
        }
        return "Rp. 0"
    }
}
