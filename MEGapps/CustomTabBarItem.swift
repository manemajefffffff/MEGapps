//
//  CustomTabBarItem.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import Foundation
import UIKit

@IBDesignable
class CustomTabBarItem: UITabBarItem {
    
    @IBInspectable var selectedImageName: String!{
        didSet {
            selectedImage = UIImage(named: selectedImageName)
        }
    }
}
