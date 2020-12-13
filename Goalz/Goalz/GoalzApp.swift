//
//  GoalzApp.swift
//  Goalz

import SwiftUI

@main
struct GoalzApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext )
        }
    }
}
