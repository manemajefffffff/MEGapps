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

struct PurchaseAdd {
    var name: String = ""
    var price: Int64 = 0
    var category: String = ""
    var deadline: Date = Date()
    var reason: String = ""
}
