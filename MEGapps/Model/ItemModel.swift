//
//  Items.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation


struct ItemModel {
    var itemID: UUID
    var name: String = ""
    var reason: String = ""
    var status: String = ""
    var category: String = ""
    var price: Int64 = 0
    var deadline: Date
    var startSavingDate: Date?
    var purchaseDate: Date?
    var createdAt: Date
    var isPrioritize: Bool = false
    
    init(itemID: UUID, name: String, reason: String, status: String, category: String, price: Int64, deadline: Date, startSavingDate: Date?, purchaseDate: Date?, createdAt: Date, isPrioritize: Bool) {
        self.itemID = itemID
        self.name = name
        self.reason = reason
        self.status = status
        self.category = category
        self.price = price
        self.deadline = deadline
        self.startSavingDate = startSavingDate
        self.purchaseDate = purchaseDate
        self.createdAt = createdAt
        self.isPrioritize = isPrioritize
    }
}
