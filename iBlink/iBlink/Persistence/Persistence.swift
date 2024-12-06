//
//  Persistence.swift
//  iBlink
//
//  Created by Gerard Serra Rodríguez on 6/12/24.
//

import CoreData

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "iBlink")
        
        // Handle in-memory store for previews or testing
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Saving context method
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // Expose context for use
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // This is the preview data for development or UI preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Sample data to work with for preview purposes
        for i in 0..<10 {
            let newTask = TaskEntity(context: viewContext)
            newTask.taskId = UUID()
            newTask.text = "Sample Task \(i)"
            newTask.isCompleted = false
            newTask.createdAt = Date()
        }
        
        // Save the context for the preview
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
}
