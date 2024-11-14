//
//  CoreDataStack.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 13/11/2024.
//


import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "StudioManager")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}