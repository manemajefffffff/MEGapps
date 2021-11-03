//
//  Items.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation


struct ItemModel {
    var itemID: UUID?
    var name: String? = ""
    var reason: String? = ""
    var status: String? = ""
    var category: String? = ""
    var price: Int64? = 0
    var deadline: Date?
    var startSavingDate: Date?
    var purchaseDate: Date?
    var createdAt: Date?
    var isPrioritize: Bool? = false
}
