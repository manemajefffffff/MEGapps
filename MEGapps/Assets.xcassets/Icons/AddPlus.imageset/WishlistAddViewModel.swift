//
//  PurchaseAddViewModel.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 10/11/21.
//

import Foundation
import Combine

class WishlistAddViewModel: NSObject {
    var items: WishlistAdd?
    
    override init(){
        self.items = WishlistAdd()
    }
}
