//
//  TrItemBudgetModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation
import CoreData

class TrItemBudget: NSManagedObject, Codable  {
    enum CodingKeys: CodingKey {
        case id
        case amount
        case createdAt
        case budget
        case items
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.amount = try container.decode(Int64.self, forKey: .amount)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.budget = try container.decode(Budget.self, forKey: .budget)
        self.items = try container.decode(Items.self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(amount, forKey: .amount)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(budget, forKey: .budget)
        try container.encode(items, forKey: .items)
    }
}
