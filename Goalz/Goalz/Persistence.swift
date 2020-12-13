//
//  Persistence.swift
//  Goalz

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newGoal = Goal(context: viewContext)
            newGoal.id = UUID()
            newGoal.endDate = Date()
            newGoal.goalDescription = "Test Description"
            newGoal.startDate = Date()
            newGoal.title = "Test Title"
        }
        do {
            try viewContext.save()
        } catch {
            // come back later
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Goalz")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
