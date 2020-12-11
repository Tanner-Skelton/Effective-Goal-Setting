//
//  GoalzApp.swift
//  Goalz
//
//  Created by Tanner Skelton on 12/11/20.
//

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
