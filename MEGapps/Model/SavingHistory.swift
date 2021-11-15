//
//  SavingHistoryModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 02/11/21.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

class SavingsHistory: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id
        case amount
        case wordings
        case createdAt
        case status
    }
    
    required convenience init(from decoder: Decoder) throws {
        // unchanged implementation
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.amount = try container.decode(Int64.self, forKey: .amount)
        self.wordings = try container.decode(String.self, forKey: .wordings)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.status = try container.decode(String.self, forKey: .status)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(amount, forKey: .amount)
        try container.encode(wordings, forKey: .wordings)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(status, forKey: .status)
    }
}
