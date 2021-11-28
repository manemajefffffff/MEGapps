//
//  CoreDataContext.swift
//  MEGapps
//
//  Created by Arya Ilham on 28/11/21.
//

import Foundation
import CoreData

class CoreDataContext {
    static let sharedCDC = CoreDataContext()
        
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MEGapps")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()

}
