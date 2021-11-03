//
//  Items.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation
import CoreData

class Items: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case reason
        case status
        case category
        case price
        case deadline
        case startSavingDate
        case purchasedDate
        case createdAt
        case isPrioritize
        case transactionItemBudget
    }
    
    required convenience init(from decoder: Decoder) throws {
        // unchanged implementation
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.reason = try container.decode(String.self, forKey: .reason)
        self.status = try container.decode(String.self, forKey: .status)
        self.category = try container.decode(String.self, forKey: .category)
        self.price = try container.decode(Int64.self, forKey: .price)
        self.deadline = try container.decode(Date.self, forKey: .deadline)
        self.startSavingDate = try container.decode(Date.self, forKey: .startSavingDate)
        self.purchasedDate = try container.decode(Date.self, forKey: .purchasedDate)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.isPrioritize = try container.decode(Bool.self, forKey: .isPrioritize)
        self.transactionItemBudget = try container.decode(Set<TrItemBudget>.self, forKey: .transactionItemBudget) as NSSet
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(reason, forKey: .reason)
        try container.encode(status, forKey: .status)
        try container.encode(category, forKey: .category)
        try container.encode(price, forKey: .price)
        try container.encode(deadline, forKey: .deadline)
        try container.encode(startSavingDate, forKey: .startSavingDate)
        try container.encode(purchasedDate, forKey: .purchasedDate)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(isPrioritize, forKey: .id)
        try container.encode(transactionItemBudget as? Set<TrItemBudget>, forKey: .transactionItemBudget)
    }
    
}
