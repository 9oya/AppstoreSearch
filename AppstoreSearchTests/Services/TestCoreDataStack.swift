//
//  TestCoreDataStack.swift
//  AppstoreSearchTests
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import AppstoreSearch
import CoreData

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: CoreDataStack.managedModelName, managedObjectModel: CoreDataStack.managedModel)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.storeContainer = container
    }
}
