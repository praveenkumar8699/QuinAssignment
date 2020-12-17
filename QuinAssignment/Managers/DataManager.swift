//
//  DataManager.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 17/12/20.
//

import Foundation
import CoreData

class DataManager : NSObject {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QuinAssignment")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static func saveContext() {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
          do {
            try context.save()
          } catch {
            // The context couldn't be saved.
            // You should add your own error handling here.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
        
    }
    
}
