//
//  BudgetModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation
import CoreData

class Budget: NSManagedObject, Codable{
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case amount
        case trItemBudget
    }
 
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.amount = try container.decode(Int64.self, forKey: .amount)
        self.trItemBudget = try container.decode(Set<TrItemBudget>.self, forKey: .trItemBudget) as NSSet
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(amount, forKey: .amount)
        try container.encode(trItemBudget as? Set<TrItemBudget>, forKey: .trItemBudget)
    }
    
}
