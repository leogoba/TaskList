//
//  StorageManager.swift
//  TaskList
//
//  Created by leogoba on 21.11.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores {_, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext

    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    func create(_ taskName: String, completion: (Task) -> Void) {
        let task = Task(context: viewContext)
        task.title = taskName
        completion(task)
        saveContext()
    }
    
    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let task = try viewContext.fetch(fetchRequest)
            completion(.success(task))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(_ task: Task, newName: String) {
        task.title = newName
        saveContext()
    }
    
    func delete(_ task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
