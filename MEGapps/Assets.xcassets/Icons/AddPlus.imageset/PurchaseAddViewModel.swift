//
//  PurchaseAddViewModel.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 10/11/21.
//

import Foundation
import Combine

class PurchaseAddViewModel: NSObject {
    var items: PurchaseAdd?
    
    override init(){
        self.items = PurchaseAdd()
    }
}
