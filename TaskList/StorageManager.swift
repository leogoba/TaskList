//
//  StorageManager.swift
//  TaskList
//
//  Created by leogoba on 21.11.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Core Data Fetching support
    func fetchData(_ completion: ([Task]) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let task = try persistentContainer.viewContext.fetch(fetchRequest)
            completion(task)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
